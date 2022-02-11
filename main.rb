require './lib/scraper'
require './lib/instructor'
require 'json'

RMPurl = "https://www.ratemyprofessors.com/search"
classSearchURL = "https://classes.osu.edu/class-search/#/"

RMPScraper = Scraper.new(RMPurl)
instructors = []

# pretty much everything after this line was just for me to test my scraper with ratemyprofessor.com 
dave = Instructor.new("David", "Ogle", "CSE")
greg = Instructor.new("Gregory", "Smith", "POLITSC")

RMPScraper.find_instructor(greg);
puts "First Name: " + greg.firstName
puts "Last Name: " + greg.lastName
puts "Department: " + greg.department
puts "Average Rating: " + greg.avgRating
puts "Number of Ratings: " + greg.numRatings.to_s
puts "Would take again percent: " + greg.wouldTakeAgainPercent
puts "Average difficulty: " + greg.avgDifficulty

puts ""

RMPScraper.find_instructor(dave);
puts "First Name: " + dave.firstName
puts "Last Name: " + dave.lastName
puts "Department: " + dave.department
puts "Average Rating: " + dave.avgRating
puts "Number of Ratings: " + dave.numRatings.to_s
puts "Would take again percent: " + dave.wouldTakeAgainPercent
puts "Average difficulty: " + dave.avgDifficulty
