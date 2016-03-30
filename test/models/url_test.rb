require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_urls

    assert Url.first.respond_to?(:url)
    assert_equal "http://yahoo.com/about", Url.second.url
    assert_equal "http://jumpstartlab.com/blog", Url.first.url
    assert_equal "http://yahoo.com/about", Url.last.url
  end

  def test_nil_does_not_get_created
    #create urls - with value nil
    # assert_equal 0, create....
    
    create_urls

    assert_equal 3, Url.count
  end

  def test_sorts_urls_most_to_least_requested
    create_urls

    assert_equal ["http://yahoo.com/about","http://jumpstartlab.com/blog"], Url.sort_most_requested
  end

  def test_return_maximum_response_time
   create_payloads
   url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
   url2 = Url.find_by(url: "http://yahoo.com/about")

   assert_equal 38, url1.max_response_time
   assert_equal 37, url2.max_response_time
  end

  def test_return_minimum_response_time
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    # assert_equal 38, url1.min_response_time
    assert_equal 36, url2.min_response_time
  end

end
