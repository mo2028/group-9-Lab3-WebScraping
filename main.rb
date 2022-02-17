require './lib/scraper'
require './lib/instructor'

CLASS_SEARCH_URL = "https://content.osu.edu/v2/classes"
RMP_URL = "https://www.ratemyprofessors.com/search"
cnum, instructorList = [], []

print "Enter a course subject (example: \"CSE\" or \"MATH\" or \"ECE\"): "
cnum[0] = gets.chomp.upcase
print "Enter a course number (example: \"3901\" or \"3345\" or \"2060\"): "
cnum[1] = gets.chomp

# create a scraper to scrape coursicle.com, put a course identifier into the course scraper, return an array of all sections of cnum.
cScraper = Scraper.new CLASS_SEARCH_URL
instructorList = cScraper.getInstructors cnum 

# create a scraper to scrape ratemyprofessor.com and find the ratings of each professor in instructorList
rmpScraper = Scraper.new RMP_URL
puts "\nHere is the information of instructors who teach #{cnum[0]} #{cnum[1]} in SP22.\n"
instructors = printRmp rmpScraper, cnum[0], instructorList
puts "There are #{instructors.length} teachers teaching #{cnum[0]} #{cnum[1]} in SP22."
