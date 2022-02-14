require 'mechanize'
require 'nokogiri'
require 'open-uri'
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

    def find_csecourse cnum
        # url = @url + "?q=cse%20#{cnum}&campus=col&p=1&term=1222&subject=cse"
        # doc = Nokogiri::HTML(URI.open(url))

        url = "https://classes.osu.edu/class-search/#/?q=cse%20#{cnum}&campus=col&p=1&term=1222"
        page = agent.get(url)
        courseArray = []

        cname = page.search('.col-md-12.light.course-info span').text # cname is always the same.

        page.search('.row div.section-container.ng-scope').each do
            courseArray.push (Course.new cnum, cname) # Each section's course number and course name should be same.
        end

        courseArray.each do |index, c|
            c.snum = page.search('span.lightweight.ng-binding').text
            c.imode = page.search('.row p.ng-binding').text
            c.cAttr = page.search('.attribute-heading.right span').text
            c.place = page.search('.col-md-6.col-sm-7 p.ng-binding').text
            c.time = page.search('.meeting-time.ng-binding').text
        end

        return courseArray # return an array of all sections of cse cnum course.

    end

end


