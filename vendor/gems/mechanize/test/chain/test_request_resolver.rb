require "helper"

class TestRequestResolver < Test::Unit::TestCase
  def test_handle_get
    v = Mechanize::Chain.new([
      Mechanize::Chain::RequestResolver.new
    ])
    hash = {
      :uri  => URI.parse('http://google.com'),
      :verb => :get
    }
    assert_nothing_raised { v.handle(hash) }
    assert_kind_of(Net::HTTP::Get, hash[:request])
    assert_equal('/', hash[:request].path)
  end

  def test_handle_post
    v = Mechanize::Chain.new([
      Mechanize::Chain::RequestResolver.new
    ])
    hash = {
      :uri  => URI.parse('http://google.com'),
      :verb => :post
    }
    assert_nothing_raised { v.handle(hash) }
    assert_kind_of(Net::HTTP::Post, hash[:request])
    assert_equal('/', hash[:request].path)
  end
end
