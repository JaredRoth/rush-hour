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

    assert_equal 36, client1.max_response_time
    assert_equal 38, client2.max_response_time
  end

  def test_return_minimum_response_time
    create_payloads(4)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal 35, client1.min_response_time
    assert_equal 37, client2.min_response_time
  end

  def test_sorts_response_times_longest_to_shortest
    create_payloads(5)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal [36, 35], client1.sort_response_times
    assert_equal [39, 38, 37], client2.sort_response_times
  end

  def test_returns_avg_response_time
    create_payloads(6)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal 35.33, client1.avg_response_time
    assert_equal 38, client2.avg_response_time
  end

  def test_returns_list_of_request_types
    create_payloads(4)

    client1 = Client.find_by(identifier: "jumpstartlab")
    client2 = Client.find_by(identifier: "yahoo")

    assert_equal ["POST", "GET"], client1.all_request_types
    assert_equal ["GET", "POST"], client2.all_request_types
  end

end
