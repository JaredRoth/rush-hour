require './test/test_helper'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_create_a_client_with_valid_attributes
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"yahoo\"}", last_response.body
    # assert_equal "{'identifier':'yahoo'}", last_response.body
  end

  def test_cannot_create_client_that_already_exists
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    assert_equal 1, Client.count
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

  def test_cannot_create_a_client_with_missing_identifier
    post '/sources', { rootUrl: "http://yahoo.com" }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_cannot_create_a_client_with_missing_rootUrl
    post '/sources', { identifier: "yahoo" }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end
end
