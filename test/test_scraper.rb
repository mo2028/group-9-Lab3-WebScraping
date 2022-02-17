require './lib/scraper'
require 'minitest/autorun'

class TestScraper < MiniTest::Test

    def setup
        # Set up two Scrapers for search score on RMP and search instructors on osu web.
        @testRMPUrl = Scraper.new "https://www.ratemyprofessors.com/search"
        @testSearchUrl = Scraper.new "https://content.osu.edu/v2/classes"
        @testGoogle = Scraper.new "https://www.google.com"
    end

    # Test if the Scraper class has the url attribute.
    def test_has_url
        assert_respond_to @testRMPUrl, :url
        assert_respond_to @testSearchUrl, :url
        assert_respond_to @testGoogle, :url
    end

    def test_remembers_url
        assert_equal "https://www.ratemyprofessors.com/search", @testRMPUrl.url
        assert_equal "https://content.osu.edu/v2/classes", @testSearchUrl.url
        assert_equal "https://www.google.com", @testGoogle.url
    end

end