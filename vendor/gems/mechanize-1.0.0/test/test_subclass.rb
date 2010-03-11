require "helper"

class TestSubclass < Test::Unit::TestCase
  def setup
    @agent = Mechanize.new
  end

  def test_send_cookie
    page = @agent.get(  :url      => "http://localhost/send_cookies",
                        :headers  => {'Cookie' => 'name=Aaron'} )
    assert_equal(1, page.links.length)
    assert_not_nil(page.links.find { |l| l.text == "name:Aaron" })
  end
  
  class Parent < Mechanize
    @html_parser = :parser
    @log = :log
  end
  
  class Child < Parent
  end
  
  def test_subclass_inherits_html_parser
    assert_equal :parser, Child.html_parser
  end
  
  def test_subclass_inherits_log
    assert_equal :log, Child.log
  end
end
