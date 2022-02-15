class Instructor 
    attr_accessor :firstName, :lastName, :avgRating, :numRatings, :wouldTakeAgainPercent, :avgDifficulty, :department
    def initialize(firstName, lastName, department)
        @firstName = firstName
        @lastName = lastName
        @department = department
        @avgRating = "N/A"
        @numRatings = "N/A"
        @wouldTakeAgainPercent = "N/A"
        @avgDifficulty = "N/A"
    end
end

def printRmp instructorList
    RMPurl = "https://www.ratemyprofessors.com/search"
    RMPScraper = Scraper.new RMPurl

    instructors, k = [], 0

    instructorList.each do |instructor|
        i, j = 0, instructor.length
        i += 1 while instructor[i] != " "
        j -= 1 while instructor[j] != " "
        fName = instructor[0..i - 1]
        lName = instructor[j + 1..instructor.length - 1]

        instructors[k] =  Instructor.new fName, lName, "CSE"
        RMPScraper.find_instructor instructors[k]

        puts "First Name: " + instructors[k].firstName
        puts "Last Name: " + instructors[k].lastName
        puts "Department: " + instructors[k].department
        puts "Average Rating: " + instructors[k].avgRating
        puts "Number of Ratings: " + instructors[k].numRatings.to_s
        puts "Would take again percent: " + instructors[k].wouldTakeAgainPercent
        puts "Average difficulty: " + instructors[k].avgDifficulty
        
        k += 1
    end

    instructors
end
