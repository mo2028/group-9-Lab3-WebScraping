require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'json'
require_relative 'instructor'
require_relative 'course'

class Scraper
    def initialize(url)
        @url = url 
    end

    def find_instructor instructor

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

        # populate instructor information
        instructor.avgRating = page.search('.liyUjw').text
        instructor.numRatings = page.search('.jMkisx a').text.to_i

        otherInfo = page.search('.kkESWs').map(&:text)
        instructor.wouldTakeAgainPercent = otherInfo[0]
        instructor.avgDifficulty = otherInfo[1]
    end

    def getInstructors cnum
        url = @url + "/search?q=#{cnum[0]}%20#{cnum[1]}&campus=col&p=1&term=1222"
        doc = JSON.parse(Nokogiri::HTML(URI.open(url)))

        # initialize empty list of instructors 
        instructorList = []
        
        # store number of returned courses
        numberOfCourses = doc['data']['courses'].size

        # find the correct course to correctly identify instructors
        i = -1
        numberOfCourses.times do |x|
            if (doc['data']['courses'][x]['course']['subject'].casecmp(cnum[0]) == 0) && (doc['data']['courses'][0]['course']['catalogNumber'].to_i).equal?(cnum[1].to_i)
                i = x
                break
            end
        end

        # push all unique instructor names associated with the given course to the array 
        doc['data']['courses'][i]['sections'].size.times do |x|
            instructorList |= [doc['data']['courses'][i]['sections'][x]['meetings'][0]['instructors'][0]['displayName']]
        end
        puts instructorList
        instructorList
    end

end


