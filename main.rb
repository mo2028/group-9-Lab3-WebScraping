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


puts greg.firstName
puts greg.lastName
puts greg.department
puts greg.avgRating
puts greg.numRatings
puts greg.wouldTakeAgainPercent
puts greg.avgDifficulty
