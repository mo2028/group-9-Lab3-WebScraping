require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'instructor'

class Scraper
    def initialize(url)
        @url = url 
    end

    def find_instructor instructor

        # generate search query based on instructor's first name and last name
        url = @url + "/teachers?query=" + instructor.firstName.downcase + "%20" + instructor.lastName.downcase + "&sid=U2Nob29sLTcyNA=="

        # store raw HTML from the query
        doc = Nokogiri::HTML(open(url))

        potentialMatches = []

        # scan the HTML for matches to "legacyId:", and store all legacy IDs in an array. these are used to generate new URLs which are then used to
        # select the most likely instructor in the event that two instructors have the same name
        doc.to_str.scan(/\"legacyId\"\s*:\s*(?<legacyId>[0-9]*)\s*,/) do |match| 
            potentialMatches.push match[0].to_i
        end

        # Each legacy ID represents one possible instructor that may or may not be the correct one. To find the most likely correct
        # professor, we search through all of the URLs and use the one that matches the department given in the class code (such as 'CSE 3901').
        # For example, say that there are two professors named Charlie Giles at Ohio State, with one of them being from the CSE department and
        # the other from the EDU department. If we search for Charlie Giles, we find the legacyId of both of them, generate a new query for each,
        # and only populate the instructor's ratings if "CSE" shows up at least once on the page. That way, we don't give the user information about
        # the Charlie Giles from the EDU department if they requested information about a CSE class.
        agent = Mechanize.new
        potentialMatches.each do |legacyId|
            url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{legacyId}"
            page = agent.get(url)

            # here is where we check whether the instructor's department shows up on the page
            if page.body.include?(instructor.department)
                instructor.avgRating = page.search('.liyUjw').text
                instructor.numRatings = page.search('.jMkisx a').text.to_i

                otherInfo = page.search('.kkESWs').map(&:text)
                instructor.wouldTakeAgainPercent = otherInfo[0]
                instructor.avgDifficulty = otherInfo[1]

                # If we populate the instructor's rating information, we don't need to keep looking through other professors if there
                # are multiple with the same name, hence this break statement.
                break
            end
        end

    end

end


