require "helper"

class TestBadLinks < Test::Unit::TestCase
  def setup
    @agent = Mechanize.new
    @page = @agent.get("http://localhost/tc_bad_links.html")
  end

  def test_space_in_link
    assert_nothing_raised do
      @agent.click @page.links.first
    end
    assert_match(/alt_text.html$/, @agent.history.last.uri.to_s)
    assert_equal(2, @agent.history.length)
  end

  def test_space_in_url
    page = nil
    assert_nothing_raised do
      page = @agent.get("http://localhost/tc_bad_links.html ")
    end
    assert_match(/tc_bad_links.html$/, @agent.history.last.uri.to_s)
    assert_equal(2, @agent.history.length)
  end
end
