require './lib/instructor'
require 'minitest/autorun'

class TestInstructor < MiniTest::Test

    def setup
        @testCharlie = Instructor.new "Charlie", "Giles", "CSE"
        @testScott = Instructor.new "Scott", "Sharkey", "CSE"
        @testAdam = Instructor.new "Adam", "Champion", "CSE"
        @testPaolo = Instructor.new "Paolo", "Bucci", "CSE"
        @testIsabel = Instructor.new "Isabel", "Puentes", "ECE"
    end

    def test_has_FirstName
        assert_respond_to @testCharlie, :firstName
        assert_respond_to @testScott, :firstName
        assert_respond_to @testAdam, :firstName
        assert_respond_to @testPaolo, :firstName
        assert_respond_to @testIsabel, :firstName
    end

    def test_has_LastName
        assert_respond_to @testCharlie, :lastName
        assert_respond_to @testScott, :lastName
        assert_respond_to @testAdam, :lastName
        assert_respond_to @testPaolo, :lastName
        assert_respond_to @testIsabel, :lastName
    end

    def test_has_Department
        assert_respond_to @testCharlie, :department
        assert_respond_to @testScott, :department
        assert_respond_to @testAdam, :department
        assert_respond_to @testPaolo, :department
        assert_respond_to @testIsabel, :department
    end

    def test_has_avgRating
        assert_respond_to @testCharlie, :avgRating
        assert_respond_to @testScott, :avgRating
        assert_respond_to @testAdam, :avgRating
        assert_respond_to @testPaolo, :avgRating
        assert_respond_to @testIsabel, :avgRating
    end

    def test_has_numRatings
        assert_respond_to @testCharlie, :numRatings
        assert_respond_to @testScott, :numRatings
        assert_respond_to @testAdam, :numRatings
        assert_respond_to @testPaolo, :numRatings
        assert_respond_to @testIsabel, :numRatings
    end

    def test_has_wouldTakeAgainPercent
        assert_respond_to @testCharlie, :wouldTakeAgainPercent
        assert_respond_to @testScott, :wouldTakeAgainPercent
        assert_respond_to @testAdam, :wouldTakeAgainPercent
        assert_respond_to @testPaolo, :wouldTakeAgainPercent
        assert_respond_to @testIsabel, :wouldTakeAgainPercent
    end

    def test_has_avgDifficulty
        assert_respond_to @testCharlie, :avgDifficulty
        assert_respond_to @testScott, :avgDifficulty
        assert_respond_to @testAdam, :avgDifficulty
        assert_respond_to @testPaolo, :avgDifficulty
        assert_respond_to @testIsabel, :avgDifficulty
    end

    def test_remembers_FirstName
        assert_equal "Charlie", @testCharlie.firstName
        assert_equal "Scott", @testScott.firstName
        assert_equal "Adam", @testAdam.firstName
        assert_equal "Paolo", @testPaolo.firstName
        assert_equal "Isabel", @testIsabel.firstName
    end

    def test_remembers_LastName
        assert_equal "Giles", @testCharlie.lastName
        assert_equal "Sharkey", @testScott.lastName
        assert_equal "Champion", @testAdam.lastName
        assert_equal "Bucci", @testPaolo.lastName
        assert_equal "Puentes", @testIsabel.lastName
    end

    def test_remembers_Department
        assert_equal "CSE", @testCharlie.department
        assert_equal "CSE", @testScott.department
        assert_equal "CSE", @testAdam.department
        assert_equal "CSE", @testPaolo.department
        assert_equal "ECE", @testIsabel.department
    end

end