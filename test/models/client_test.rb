require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    client1 = Client.create(:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com")
    client2 = Client.create(:identifier => "yahoo", :rootUrl => "http://yahoo.com")
    client3 = Client.create(:identifier => "apple", :rootUrl => "http://apple.com")

    assert client1.respond_to?(:identifier)
    assert client1.respond_to?(:rootUrl)

    assert_equal "jumpstartlab", client1.identifier
    assert_equal "http://jumpstartlab.com", client1.rootUrl

    assert_equal "yahoo", client2.identifier
    assert_equal "http://yahoo.com", client2.rootUrl

    assert_equal "apple", client3.identifier
    assert_equal "http://apple.com", client3.rootUrl
  end

  def test_nil_does_not_get_created
    Client.create(nil)

    assert_equal 0, Client.count
  end




  def test_return_clients_maximum_response_time
    create_payloads(4)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal 37, client1.max_response_time
    assert_equal 38, client2.max_response_time
  end

  def test_return_minimum_response_time
    create_payloads(4)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal 35, client1.min_response_time
    assert_equal 36, client2.min_response_time
  end

  def test_returns_avg_response_time
    create_payloads(6)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal 37, client1.avg_response_time
    assert_equal 36.33, client2.avg_response_time
  end

  def test_returns_list_of_request_types
    create_payloads(4)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert client1.all_request_types.include?("POST")
    assert client1.all_request_types.include?("GET")

    refute client2.all_request_types.include?("POST")
    assert client2.all_request_types.include?("GET")
  end

  def test_sorts_clients_urls_most_to_least_requested
    create_payloads(9)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal ["http://jumpstartlab.com/blog", "http://jumpstartlab.com/about", "http://jumpstartlab.com/apply"], client1.sort_clients_most_requested_urls
    assert_equal ["http://yahoo.com/blog", "http://yahoo.com/about"], client2.sort_clients_most_requested_urls
  end

  def test_lists_clients_browser_breakdown
    create_payloads(9)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert client1.clients_browser_breakdown.include?("Chrome")
    assert client1.clients_browser_breakdown.include?("Safari")
    assert client1.clients_browser_breakdown.include?("Firefox")

    assert client2.clients_browser_breakdown.include?("Chrome")
    assert client2.clients_browser_breakdown.include?("Safari")
  end

  def test_lists_clients_operating_system_breakdown
    create_payloads(9)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert client1.clients_operating_system_breakdown.include?("Macintosh")
    assert client1.clients_operating_system_breakdown.include?("Windows")

    assert client2.clients_operating_system_breakdown.include?("Macintosh")
    assert client2.clients_operating_system_breakdown.include?("Windows")
  end

  def test_displays_all_resolutions
    create_payloads(9)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    ["1920x1280"].each do |res|
      assert client1.list_clients_resolutions.include?(res)
    end

    ["720x500", "800x600", "1920x1280"].each do |res|
      assert client2.list_clients_resolutions.include?(res)
    end
  end

  def test_finds_clients_most_used_request_types
    create_payloads(9)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal "GET", client1.clients_most_frequent_request_types
    assert_equal "GET", client2.clients_most_frequent_request_types
  end
end
