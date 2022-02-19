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

def printRmpCoursicle rmpScraper, department, instructorList
    # initialize empty array of instructor objects
    instructors, i = [], 0

    instructorList.each do |instructorNames|
        puts "\nNo.#{i + 1}:"
        # get the first and last name of the each instructor from the mechanize link object
        instructorName = instructorNames.text.split(" ")
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

def printRmpOSU rmpScraper, department, instructorList
    # initialize empty array of instructor objects
    instructors = []

    instructorList.length.times do |i|
        # get the first and last name of the each instructor from the mechanize link object
        instructorName = instructorList[i].split(" ")
        fName = instructorName[0]
        lName = instructorName[instructorName.length - 1]

        # add instructor to the list of instructor objects, and search ratemyprofessor for that instructor
        instructors[i] = Instructor.new fName, lName, department
        rmpScraper.getInstructorRating instructors[i]
        
        # print important information about each instructor
        puts ""
        puts "First Name: " + instructors[i].firstName
        puts "Last Name: " + instructors[i].lastName
        puts "Average Rating: " + instructors[i].avgRating
        puts "Number of Ratings: " + instructors[i].numRatings
        puts "Would take again percent: " + instructors[i].wouldTakeAgainPercent
        puts "Average difficulty: " + instructors[i].avgDifficulty
        puts ""
    end
    instructors
end