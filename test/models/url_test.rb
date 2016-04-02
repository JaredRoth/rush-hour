require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    url1 = Url.create(:url => "http://jumpstartlab.com/blog")
    url2 = Url.create(:url => "http://yahoo.com/about")
    url3 = Url.create(:url => "http://yahoo.com/about")

    assert url1.respond_to?(:url)
    assert_equal "http://yahoo.com/about", url2.url
    assert_equal "http://jumpstartlab.com/blog", url1.url
    assert_equal "http://yahoo.com/about", url3.url
  end

  def test_nil_does_not_get_created
    Url.create(nil)

    assert_equal 0, Url.count
  end

  def test_sorts_urls_most_to_least_requested
    create_payloads(3)

    assert_equal ["http://jumpstartlab.com/blog", "http://yahoo.com/about"], Url.sort_most_requested
  end

  def test_return_urls_maximum_response_time
   create_payloads(4)

   url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
   url2 = Url.find_by(url: "http://yahoo.com/about")

   assert_equal 36, url1.max_response_time
   assert_equal 38, url2.max_response_time
  end

  def test_return_minimum_response_time
    create_payloads(4)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal 35, url1.min_response_time
    assert_equal 37, url2.min_response_time
  end

  def test_sorts_response_times_longest_to_shortest
    create_payloads(5)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal [36, 35], url1.sort_response_times
    assert_equal [39, 38, 37], url2.sort_response_times
  end

  def test_returns_avg_response_time
    create_payloads(6)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal 35.33, url1.avg_response_time
    assert_equal 38, url2.avg_response_time
  end

  def test_returns_list_of_request_types
    create_payloads(4)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal ["POST", "GET"], url1.all_request_types
    assert_equal ["GET", "POST"], url2.all_request_types
  end

  def test_returns_top_three_referrers
    create_payloads(9)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal ["http://apple.com", "http://jumpstartlab.com", "http://yahoo.com"], url1.top_referrers
    assert_equal ["http://yahoo.com", "http://apple.com"], url2.top_referrers
  end

  def test_returns_top_three_user_agents
    create_payloads(9)

    url1 = Url.find_by(url: "http://jumpstartlab.com/blog")
    url2 = Url.find_by(url: "http://yahoo.com/about")

    assert_equal ["Chrome, Macintosh", "Safari, Macintosh", "Chrome, Windows"], url1.top_user_agents
    assert_equal ["Safari, Windows", "Firefox, Macintosh"], url2.top_user_agents
  end
end
