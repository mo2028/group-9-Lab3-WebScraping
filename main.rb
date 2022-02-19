require './lib/scraper'
require './lib/instructor'

COURSICLE_SEARCH_URL = "https://www.coursicle.com/osu/courses"
OSU_SEARCH_URL = "https://content.osu.edu/v2/classes"
RMP_URL = "https://www.ratemyprofessors.com/search"

cnum = []
instructorList = []
rmpScraper = Scraper.new RMP_URL

print "Enter a course subject (example: \"CSE\" or \"MATH\" or \"ECE\"): "
cnum[0] = gets.chomp.upcase

print "Enter a course number (example: \"3901\" or \"3345\" or \"2060\"): "
cnum[1] = gets.chomp

puts ""
print "Enter '1' to scrape from the OSU Class Search Website\n"
print "Enter '2' to scrape from Coursicle: (WARNING: EXPERIMENTAL - MAY NOT WORK ON ALL NETWORKS)\n"
print "Enter anything else to quit the program\n"
print "Choice: "
choice = gets.chomp

if choice == '1'
    # create a scraper to scrape osu websire, put a course identifier into the course scraper, return an array of all sections of cnum.
    osuScraper = Scraper.new OSU_SEARCH_URL
    instructorList = osuScraper.getInstructorsOSU cnum 

    # retrieve information about professors found with the OSU class search
    printRmp(rmpScraper, cnum[0], instructorList)

elsif choice == '2'
    # create a scraper to scrape coursicle.com, put a course identifier into the course scraper, return an array of all sections of cnum.
    coursicleScraper = Scraper.new COURSICLE_SEARCH_URL
    instructorList = coursicleScraper.getInstructorsCoursicle cnum

    # retrieve information about professors found with the Coursicle class search
    printRmp(rmpScraper, cnum[0], instructorList)
    
else 
end

