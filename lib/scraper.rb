require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'json'
require_relative 'instructor'

class Scraper
    attr_accessor :url
    def initialize(url)
        @url = url
    end

    def getInstructorsCoursicle cnum
        begin
            # generate search query based on class department and number
            url = @url + "/#{cnum[0].upcase}/#{cnum[1]}"
            agent = Mechanize.new
            agent.user_agent_alias = 'Linux Mozilla'
        
            # initialize empty list of instructors 
            instructorList = []

            # retrieve the page from coursicle
            page = agent.get(url)
            title = page.title
        
            # print error message if user runs into an issue with the coursicle captcha
            if title.include? "aptcha"
                puts "Sorry, the Coursicle search will not work on this network. Using the OSU class search instead."
                backupURL = "https://content.osu.edu/v2/classes"
                osuScraper = Scraper.new backupURL
                instructorList = osuScraper.getInstructorsOSU cnum
                return instructorList
            end
            # find all instructors listed on the page if the page is found
            instructorList = page.links_with(href: %r{https://www.coursicle.com/osu/professors/})
        rescue Mechanize::ResponseCodeError => e
            abort "Error: Class not found"
        end
    end

    def getInstructorsOSU cnum
        url = @url + "/search?q=#{cnum[0]}%20#{cnum[1]}&campus=col&p=1&term=1222"
        doc = JSON.parse(Nokogiri::HTML(URI.open(url)))

        # initialize empty list of instructors 
        # store number of returned courses
        instructorList, numberOfCourses, i = [], doc['data']['courses'].size, -1

        # find the correct course to correctly identify instructors
        numberOfCourses.times do |x|
            if (doc['data']['courses'][x]['course']['subject'].casecmp(cnum[0]) == 0) && (doc['data']['courses'][0]['course']['catalogNumber'].to_i).equal?(cnum[1].to_i)
                i = x
                break
            end
        end

        # push all unique instructor names associated with the given course to the array 
        doc['data']['courses'][i]['sections'].size.times do |x|
            doc['data']['courses'][i]['sections'][x]['meetings'][0]['instructors'].size.times do |y|
                if !doc['data']['courses'][i]['sections'][x]['meetings'][0]['instructors'][y]['displayName'].nil?
                    instructorList |= [doc['data']['courses'][i]['sections'][x]['meetings'][0]['instructors'][y]['displayName']]
                end
            end
        end
        instructorList
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
                begin
                    url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{legacyId}"
                    page = agent.get(url)
 
                    if page.body.include?(instructor.department[0..2]) && !page.links_with(href: %r{sid=724}).length.equal?(0)
                        similarityScores.push(1 + instructor.numRatings = page.search('.jMkisx a').text.to_i)
                    else
                        similarityScores << 0
                    end
                rescue Mechanize::ResponseCodeError => e
                    puts "Error: professor not found"
                end
            end


            # open the page that most closely matches the instructor's department
            bestMatch = potentialMatches[similarityScores.index(similarityScores.max)]
            url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{bestMatch}"
            page = agent.get(url)

            # one last check to make sure we update the ratings only if ratemyprofessor finds the right instructor
            # if RMP cannot find the right professor, it will open whichever one has the highest similarity score,
            # which could be 0, so we check that the last name displayed on the page is the last name of the instructor
            # we are looking for
            lastNameOnPage = page.search('.glXOHH').text.split.last
            if lastNameOnPage == instructor.lastName
                # populate instructor information
                instructor.avgRating = page.search('.liyUjw').text + "/5" if page.search('.liyUjw').text.to_s != "N/A"
                instructor.numRatings = page.search('.jMkisx a').text.to_s if page.search('.jMkisx a').text.to_s != "Add a rating."

                otherInfo = page.search('.kkESWs').map(&:text)
                instructor.wouldTakeAgainPercent = otherInfo[0].to_s if !otherInfo[0].nil?
                instructor.avgDifficulty = otherInfo[1].to_s if !otherInfo[1].nil?
            end
        end
    end

end