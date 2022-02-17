require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'instructor'

class Scraper
    def initialize(url)
        @url = url 
    end

    def getInstructors cnum
        # generate search query based on class department and number
        url = @url + "/#{cnum[0].upcase}/#{cnum[1]}"
        agent = Mechanize.new
        agent.user_agent_alias = 'Mac Safari'

        # initialize empty list of instructors 
        instructorList = []

        # retrieve the page from coursicle
        page = agent.get(url)

        # find all instructors listed on the page if the page is found
        instructorList = page.links_with(href: %r{https://www.coursicle.com/osu/professors/})
    end

    def getInstructorRating instructor

        # generate search query based on instructor's first name and last name
        url = @url + "/teachers?query=" + instructor.firstName.downcase[0..1] + "%20" + instructor.lastName.downcase + "&sid=U2Nob29sLTcyNA=="

        # store raw HTML from the query
        doc = Nokogiri::HTML(URI.open(url))

        potentialMatches = []
        similarityScores = []

        # scan the HTML for matches to "legacyId:", and store all legacy IDs in an array. these are used to generate new URLs which are then used to
        # select the most likely instructor in the event that two instructors have the same name
        doc.to_str.scan(/\"legacyId\"\s*:\s*(?<legacyId>[0-9]*)\s*,/) do |match| 
            potentialMatches.push match[0].to_i
        end

        # Each legacy ID represents one possible instructor that may or may not be the correct one. To find the most likely correct
        # professor, we search through all of the URLs and use the one that matches the department given in the class code (such as 'CSE 3901').
        # For example, say that there are two professors named Charlie Giles at Ohio State, with one of them being from the CSE department and
        # the other from the EDU department. If we search for Charlie Giles, we find the legacyId of both of them, generate a new query for each,
        # and populate the instructor's ratings based on the page that contains text that most closely matches "CSE"
        unless potentialMatches.length.equal?(0)
            agent = Mechanize.new
            potentialMatches.each do |legacyId|
                url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{legacyId}"
                page = agent.get(url)

                # Search page and find similarity score (how much does department match text on the page)
                i = 0
                i += 1 while i < instructor.department.length - 1 && page.body.include?(instructor.department[0..i])
                similarityScores.push i
            end

            # open the page that most closely matches the instructor's department
            bestMatch = potentialMatches[similarityScores.index(similarityScores.max)]
            url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{bestMatch}"
            page = agent.get(url)

            # one last check to make sure we update the ratings only if ratemyprofessor finds the right instructor
            # if RMP cannot find the right professor, it will open whichever one has the highest similarity score,
            # which could be 0, so we check that the last name displayed on the page is the last name of the instructor
            # we are looking for
            lastNameOnPage = page.search('.glXOHH').text.split[0]
            if lastNameOnPage == instructor.lastName
                # populate instructor information
                instructor.avgRating = page.search('.liyUjw').text + "/5"
                instructor.numRatings = page.search('.jMkisx a').text.to_s if page.search('.jMkisx a').text.to_s != "Add a rating."

                otherInfo = page.search('.kkESWs').map(&:text)
                instructor.wouldTakeAgainPercent = otherInfo[0].to_s
                instructor.avgDifficulty = otherInfo[1].to_s
            end
        end
    end

end


