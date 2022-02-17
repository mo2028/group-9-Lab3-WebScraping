require './lib/scraper'
require 'minitest/autorun'

class TestScraper < MiniTest::Test

    def setup
        # Set up two Scrapers for search score on RMP and search instructors on osu web.
        @testRMPUrl = Scraper.new "https://www.ratemyprofessors.com/search"
        @testSearchUrl = Scraper.new "https://www.coursicle.com/osu/courses/"
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
        assert_respond_to @testGoogle, :url
    end

    def test_remembers_url
        assert_equal "https://www.ratemyprofessors.com/search", @testRMPUrl.url
        assert_equal "https://www.coursicle.com/osu/courses/", @testSearchUrl.url
        assert_equal "https://www.google.com", @testGoogle.url
    end

    def test_getInstructors
        expCse3901Instr = ["Bob Joseph", "Charlie Giles", "Scott Sharkey", "Dustin Williams", "Paul Sivilotti", "Mukul Soundarajan", "Paolo Sivilotti", "Robert Joseph", "Charles Giles", "Naeem Shareef"]
        cse3901Instr,i = @testSearchUrl.getInstructors(@cse3901),0
        cse3901Instr.each do |instr|
            assert_equal instr.text, expCse3901Instr[i]
            i+=1
        end

        expMath3345Instr = ["Andrzej Derdzinski", "Zbigniew Fiedorowicz", "Jingyin Huang", "Tae Kim", "Max Kutler", "Caroline Terry", "Yeor Hafuta", "Daniel Thompson", "Gabe Conant", "Trent Ohl", "Roy Joshua", "Alexander Mcdonald", "Ghaith Hiary", "Anthony Nance", "Nigel Pynn-Coates", "Kenneth Koenig"]
        math3345Instr,i = @testSearchUrl.getInstructors(@math3345),0
        math3345Instr.each do |instr|
            assert_equal instr.text, expMath3345Instr[i]
            i+=1
        end

        expEce2020Instr = ["Isabel Puentes", "To Announced", "Harshith Gunturu", "Hamza Anwar", "Furrukh Khan", "Arti Vedula", "Amber Arquitola", "Liang Guo", "Banaful Paul", "Hao Li", "Gregg Chapman", "Huaqing Xiong", "Siamak Shojaei", "Daijiafan Mao", "Benjamin Coifman", "Himaja Kesavareddigari"]
        ece2020Instr,i = @testSearchUrl.getInstructors(@ece2020),0
        ece2020Instr.each do |instr|
            assert_equal instr.text, expEce2020Instr[i]
            i+=1
        end

        expEce2060Instr = ["Furrukh Khan", "To Announced", "Bernie Melus", "Xinmiao Zhang", "Betty Anderson", "Ryan Patton", "Mustafa Cantas", "Maruf Hossain", "Ananya Mahanti", "George Valco", "Gregg Chapman", "Banaful Paul", "Zhe Wang", "Xiaodan Wang", "Himaja Kesavareddigari", "Jiantong Li"]
        ece2060Instr,i = @testSearchUrl.getInstructors(@ece2060),0
        ece2060Instr.each do |instr|
            assert_equal instr.text, expEce2060Instr[i]
            i+=1
        end

        expCse2221Instr = ["Veronica Thai", "Paul Sivilotti", "Paolo Bucci", "Michael Fritz", "Mirkamil Mierkamili", "Adam Grupa", "Steve Gomori", "Piyush Chawla", "Jeremy Grifski", "Alan Weide", "Nyigel Spann", "Christine Kiel", "Rui Qiu", "Max Taylor", "Eduardo Gainza", "Matt Boggus"]
        cse2221Instr,i = @testSearchUrl.getInstructors(@cse2221),0
        cse2221Instr.each do |instr|
            assert_equal instr.text, expCse2221Instr[i]
            i+=1
        end
    end

    def test_getInstructorRating
        @testRMPUrl.getInstructorRating @testCharlie
        assert_equal @testCharlie.firstName, "Charlie"
        assert_equal @testCharlie.lastName, "Giles"
        assert_equal @testCharlie.department, "CSE"
        assert_equal @testCharlie.avgRating, "4.2/5"
        assert_equal @testCharlie.numRatings.to_str.split[0], "7"
        assert_equal @testCharlie.wouldTakeAgainPercent, "67%"
        assert_equal @testCharlie.avgDifficulty, "2.5"

        @testRMPUrl.getInstructorRating @testScott
        assert_equal @testScott.firstName, "Scott"
        assert_equal @testScott.lastName, "Sharkey"
        assert_equal @testScott.department, "CSE"
        assert_equal @testScott.avgRating, "1/5"
        #assert_equal @testScott.numRatings.to_s, "1 ratings"
        assert_equal @testScott.wouldTakeAgainPercent, "0%"
        assert_equal @testScott.avgDifficulty, "4"

        @testRMPUrl.getInstructorRating @testAdam
        assert_equal @testAdam.firstName, "Adam"
        assert_equal @testAdam.lastName, "Champion"
        assert_equal @testAdam.department, "CSE"
        assert_equal @testAdam.avgRating, "2.2/5"
        #assert_equal @testAdam.numRatings.to_s, "43 ratings"
        assert_equal @testAdam.wouldTakeAgainPercent, "14%"
        assert_equal @testAdam.avgDifficulty, "3.7"

        @testRMPUrl.getInstructorRating @testPaolo
        assert_equal @testPaolo.firstName, "Paolo"
        assert_equal @testPaolo.lastName, "Bucci"
        assert_equal @testPaolo.department, "CSE"
        assert_equal @testPaolo.avgRating, "3.1/5"
        #assert_equal @testPaolo.numRatings.to_s, "109 ratings"
        assert_equal @testPaolo.wouldTakeAgainPercent, "35%"
        assert_equal @testPaolo.avgDifficulty, "4"

        @testRMPUrl.getInstructorRating @testIsabel
        assert_equal @testIsabel.firstName, "Isabel"
        assert_equal @testIsabel.lastName, "Puentes"
        assert_equal @testIsabel.department, "ECE"
        assert_equal @testIsabel.avgRating, "3.9/5"
        #assert_equal @testIsabel.numRatings.to_s, "22 ratings"
        assert_equal @testIsabel.wouldTakeAgainPercent, "69%"
        assert_equal @testIsabel.avgDifficulty, "3"

    end

end