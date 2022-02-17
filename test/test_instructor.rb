require './lib/instructor'
require 'minitest/autorun'

class TestInstructor < MiniTest::Test

    def setup
        @testCharlie = Instructor.new "Charlie", "Giles", "CSE"
        @testScott = Instructor.new "Scott", "Sharkey", "CSE"
        @testAdam = Instructor.new "Adam", "Champion", "CSE"
    end

    def test_has_FirstName
        assert_respond_to @testCharlie, :firstName
        assert_respond_to @testScott, :firstName
        assert_respond_to @testAdam, :firstName
    end

    def test_has_LastName
        assert_respond_to @testCharlie, :lastName
        assert_respond_to @testScott, :lastName
        assert_respond_to @testAdam, :lastName
    end

    def test_has_Department
        assert_respond_to @testCharlie, :department
        assert_respond_to @testScott, :department
        assert_respond_to @testAdam, :department
    end

    def test_has_avgRating
        assert_respond_to @testCharlie, :avgRating
        assert_respond_to @testScott, :avgRating
        assert_respond_to @testAdam, :avgRating
    end

    def test_has_numRatings
        assert_respond_to @testCharlie, :numRatings
        assert_respond_to @testScott, :numRatings
        assert_respond_to @testAdam, :numRatings
    end

    def test_has_wouldTakeAgainPercent
        assert_respond_to @testCharlie, :wouldTakeAgainPercent
        assert_respond_to @testScott, :wouldTakeAgainPercent
        assert_respond_to @testAdam, :wouldTakeAgainPercent
    end

    def test_has_avgDifficulty
        assert_respond_to @testCharlie, :avgDifficulty
        assert_respond_to @testScott, :avgDifficulty
        assert_respond_to @testAdam, :avgDifficulty
    end

    def test_remembers_FirstName
        assert_equal "Charlie", @testCharlie.firstName
        assert_equal "Scott", @testScott.firstName
        assert_equal "Adam", @testAdam.firstName
    end

    def test_remembers_LastName
        assert_equal "Giles", @testCharlie.lastName
        assert_equal "Sharkey", @testScott.lastName
        assert_equal "Champion", @testAdam.lastName
    end

    def test_remembers_FirstName
        assert_equal "CSE", @testCharlie.department
        assert_equal "CSE", @testScott.department
        assert_equal "CSE", @testAdam.department
    end

end