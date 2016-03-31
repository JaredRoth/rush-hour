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

   assert_equal 39, url1.urls_max_response_time
   assert_equal 37, url2.urls_max_response_time
  end

  def test_return_minimum_response_time
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal 35, url1.urls_min_response_time
    assert_equal 36, url2.urls_min_response_time
  end

  def test_sorts_response_times_longest_to_shortest
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal [39,38,37,35], url1.sort_urls_response_times
    assert_equal [37,36], url2.sort_urls_response_times
  end

  def test_returns_urls_avg_response_time
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal 37.25, url1.urls_avg_response_time
    assert_equal 36.5, url2.urls_avg_response_time
  end

  def test_returns_list_of_urls_request_types
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal ["GET"], url1.urls_request_types
    assert_equal ["POST", "GET"], url2.urls_request_types
  end

  def test_returns_top_three_referrers
    create_payloads

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal ["", "", ""], url1.urls_top_referrers
    assert_equal ["", "", ""], url2.urls_top_referrers
  end
end
