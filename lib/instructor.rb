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

def printRmp rmpScraper, department, instructorList
    # initialize empty array of instructor objects
    instructors, i = [], 0

    instructorList.each do |instructorNames|
        puts "No.#{i + 1}:"
        # get the first and last name of the each instructor from the mechanize link object
        instructorName = instructorNames.split(" ")
        fName = instructorName[0]
        lName = instructorName[instructorName.length - 1]

        # add instructor to the list of instructor objects, and search ratemyprofessor for that instructor
        instructor = Instructor.new fName, lName, department
        instructors << instructor
        rmpScraper.getInstructorRating instructor
        
        # print important information about each instructor
        puts "First Name: " + instructor.firstName
        puts "Last Name: " + instructor.lastName
        puts "Average Rating: " + instructor.avgRating
        puts "Number of Ratings: " + instructor.numRatings.to_s
        puts "Would take again percent: " + instructor.wouldTakeAgainPercent
        puts "Average difficulty: " + instructor.avgDifficulty
        puts ""
        i += 1
    end
    instructors
end