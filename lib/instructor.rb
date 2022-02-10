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