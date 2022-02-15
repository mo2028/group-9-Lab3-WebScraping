require './lib/scraper'
require './lib/instructor'
require 'json'

RMPurl = "https://www.ratemyprofessors.com/search"
classSearchURL = "https://content.osu.edu/v2/classes"
cnum = []
# RMPScraper = Scraper.new(RMPurl)
# instructors = []

# # pretty much everything after this line was just for me to test my scraper with ratemyprofessor.com 
# dave = Instructor.new("David", "Ogle", "CSE")
# greg = Instructor.new("Gregory", "Smith", "POLITSC")

# RMPScraper.find_instructor(greg)
# puts "First Name: " + greg.firstName
# puts "Last Name: " + greg.lastName
# puts "Department: " + greg.department
# puts "Average Rating: " + greg.avgRating
# puts "Number of Ratings: " + greg.numRatings.to_s
# puts "Would take again percent: " + greg.wouldTakeAgainPercent
# puts "Average difficulty: " + greg.avgDifficulty

cScraper = Scraper.new classSearchURL
print "Enter a course subject (example: \"CSE\" or \"MATH\" or \"ECE\"): "
cnum[0] = gets.chomp.downcase

print "Enter a course number (example: \"3901\" or \"3345\" or \"2060\"): "
cnum[1] = gets.chomp
# Put a course class into the course scraper, return an array of all sections of cnum.
instructorList = getInstructors cnum 
instructors = printRmp instructorList
