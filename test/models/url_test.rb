require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    Url.create(:url => "http://jumpstartlab.com/blog")
    Url.create(:url => "http://yahoo.com/about")
    Url.create(:url => "http://yahoo.com/about")

    assert Url.first.respond_to?(:url)
    assert_equal "http://yahoo.com/about", Url.second.url
    assert_equal "http://jumpstartlab.com/blog", Url.first.url
    assert_equal "http://yahoo.com/about", Url.last.url
  end

  def test_nil_does_not_get_created
    Url.create(nil)

    assert_equal 0, Url.count
  end

  def test_sorts_urls_most_to_least_requested
    create_payloads

    assert_equal ["http://jumpstartlab.com/blog", "http://yahoo.com/about"], Url.sort_most_requested
  end

  def test_return_maximum_response_time
   create_payloads
   url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
   url2 = Url.find_by(url: "http://yahoo.com/about")

   assert_equal 39, url1.max_response_time
   assert_equal 37, url2.max_response_time
  end

  def test_return_minimum_response_time
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal 35, url1.min_response_time
    assert_equal 36, url2.min_response_time
  end
end
