require './lib/scraper'
require 'minitest/autorun'

class TestScraper < MiniTest::Test

    def setup
        # Set up two Scrapers for search score on RMP and search instructors on osu web.
        @testRMPUrl = Scraper.new "https://www.ratemyprofessors.com/search"
        @testSearchUrl = Scraper.new "https://content.osu.edu/v2/classes"
        @testCoursicleUrl = Scraper.new "https://www.coursicle.com/osu/courses/"
        @testGoogle = Scraper.new "https://www.google.com"
        
        # Set up classes to look for in tests
        @cse3901 = ["CSE", "3901"]
        @math3345 = ["MATH", "3345"]
        @ece2020 = ["ECE", "2020"]
        @ece2060 = ["ECE", "2060"]
        @cse2221 = ["CSE", "2221"]

        # Set up professors to test getInstructorRatings
        @testCharlie = Instructor.new "Charlie", "Giles", "CSE"
        @testScott = Instructor.new "Scott", "Sharkey", "CSE"
        @testAdam = Instructor.new "Adam", "Champion", "CSE"
        @testPaolo = Instructor.new "Paolo", "Bucci", "CSE"
        @testIsabel = Instructor.new "Isabel", "Puentes", "ECE"
        
    end

    # Test if the Scraper class has the url attribute.
    def test_has_url
        assert_respond_to @testRMPUrl, :url
        assert_respond_to @testSearchUrl, :url
        assert_respond_to @testCoursicleUrl, :url
        assert_respond_to @testGoogle, :url
    end

    def test_remembers_url
        assert_equal "https://www.ratemyprofessors.com/search", @testRMPUrl.url
        assert_equal "https://content.osu.edu/v2/classes", @testSearchUrl.url
        assert_equal "https://www.coursicle.com/osu/courses/", @testCoursicleUrl.url
        assert_equal "https://www.google.com", @testGoogle.url
    end

    def test_getInstructorsOSU
        expCse3901Instr = ["Bob Joseph", "Charlie Giles", "Scott Sharkey", "Dustin Williams"]
        cse3901Instr,i = @testSearchUrl.getInstructorsOSU(@cse3901),0
        cse3901Instr.each do |instr|
            assert_equal instr, expCse3901Instr[i]
            i+=1
        end

        expMath3345Instr = ["Andrzej J Derdzinski", "Zbigniew Fiedorowicz", "Jingyin Huang", "Tae Eun Kim", "Max Kutler", "Caroline Terry", "Yeor Hafuta", "Daniel James Thompson", "Gabe Conant", "Trent H Ohl", "Roy Joshua", "Alexander Keith McDonald"]
        math3345Instr,i = @testSearchUrl.getInstructorsOSU(@math3345),0
        math3345Instr.each do |instr|
            assert_equal instr, expMath3345Instr[i]
            i+=1
        end

        expEce2020Instr = ["Isabel Fernandez Puentes", "Harshith Gunturu", "Maruf Hossain", "Ahmed Yasser Hamed Ramzy Abdelaziz"]
        ece2020Instr,i = @testSearchUrl.getInstructorsOSU(@ece2020),0
        ece2020Instr.each do |instr|
            assert_equal instr, expEce2020Instr[i]
            i+=1
        end

        expEce2060Instr = ["Furrukh Saeed Khan", "Bernie Melus", "Banaful Paul", "Srinivasan Subramaniyan", "Xinmiao Zhang"]
        ece2060Instr,i = @testSearchUrl.getInstructorsOSU(@ece2060),0
        ece2060Instr.each do |instr|
            assert_equal instr, expEce2060Instr[i]
            i+=1
        end

        expCse2221Instr = ["Veronica Thai", "Paul Sivilotti", "Paolo Bucci", "Michael Fritz", "mirkamil Mierkamili", "Adam Russell Grupa", "Steve Gomori", "Piyush Chawla", "Jeremy Grifski", "Alan Weide", "Nyigel Keslyon Spann", "Christine Ann Kiel", "Rui Qiu"]
        cse2221Instr,i = @testSearchUrl.getInstructorsOSU(@cse2221),0
        cse2221Instr.each do |instr|
            assert_equal instr, expCse2221Instr[i]
            i+=1
        end
    end

    def test_getInstructorRating
        @testRMPUrl.getInstructorRating @testCharlie
        assert_equal @testCharlie.firstName, "Charlie"
        assert_equal @testCharlie.lastName, "Giles"
        assert_equal @testCharlie.department, "CSE"
        assert_equal @testCharlie.avgRating, "4.2/5"
        assert_equal @testCharlie.numRatings.gsub(/[[:space:]]/, ''), "7ratings"
        assert_equal @testCharlie.wouldTakeAgainPercent, "67%"
        assert_equal @testCharlie.avgDifficulty, "2.5"

        @testRMPUrl.getInstructorRating @testScott
        assert_equal @testScott.firstName, "Scott"
        assert_equal @testScott.lastName, "Sharkey"
        assert_equal @testScott.department, "CSE"
        assert_equal @testScott.avgRating, "1/5"
        assert_equal @testScott.numRatings.gsub(/[[:space:]]/, ''), "1ratings"
        assert_equal @testScott.wouldTakeAgainPercent, "0%"
        assert_equal @testScott.avgDifficulty, "4"

        @testRMPUrl.getInstructorRating @testAdam
        assert_equal @testAdam.firstName, "Adam"
        assert_equal @testAdam.lastName, "Champion"
        assert_equal @testAdam.department, "CSE"
        assert_equal @testAdam.avgRating, "2.2/5"
        assert_equal @testAdam.numRatings.gsub(/[[:space:]]/, ''), "43ratings"
        assert_equal @testAdam.wouldTakeAgainPercent, "14%"
        assert_equal @testAdam.avgDifficulty, "3.7"

        
        @testRMPUrl.getInstructorRating @testPaolo
        assert_equal @testPaolo.firstName, "Paolo"
        assert_equal @testPaolo.lastName, "Bucci"
        assert_equal @testPaolo.department, "CSE"
        assert_equal @testPaolo.avgRating, "3.1/5"
        assert_equal @testPaolo.numRatings.gsub(/[[:space:]]/, ''), "109ratings"
        assert_equal @testPaolo.wouldTakeAgainPercent, "35%"
        assert_equal @testPaolo.avgDifficulty, "4"
        

        @testRMPUrl.getInstructorRating @testIsabel
        assert_equal @testIsabel.firstName, "Isabel"
        assert_equal @testIsabel.lastName, "Puentes"
        assert_equal @testIsabel.department, "ECE"
        assert_equal @testIsabel.avgRating, "3.9/5"
        assert_equal @testIsabel.numRatings.gsub(/[[:space:]]/, ''), "22ratings"
        assert_equal @testIsabel.wouldTakeAgainPercent, "69%"
        assert_equal @testIsabel.avgDifficulty, "3"

    end

end