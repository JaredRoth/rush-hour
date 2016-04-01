require './test/test_helper'

class ReceivePayloadTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_create_a_payload_with_valid_attributes
    post '/sources', { client: { identifier: "yahoo", rootUrl: "http://yahoo.com" } }
    post '/sources/yahoo/data', { payload_request: {payload:'{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}}
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'yahoo'}", last_response.body
  end

  def test_cannot_create_a_payload_that_already_exists
    skip
    post '/sources', { client: { identifier: "yahoo", rootUrl: "http://yahoo.com" } }
    post '/sources/yahoo/data', { payload_request: 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' }
    assert_equal 1, Client.count
    post '/sources/yahoo/data', { payload_request: 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' }
    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Change this too", last_response.body
  end

  def test_cannot_create_a_payload_with_unknown_identifier
    skip
    post '/sources', { client: { identifier: "yahoo", rootUrl: "http://yahoo.com" } }
    post '/sources/jumpstart/data', { payload_request: 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' }
    assert_equal 0, Client.count
    assert_equal 403, last_response.status
    assert_equal "Wrong ID", last_response.body
  end

  def test_cannot_create_a_payload_with_missing_rootUrl
    skip
    post '/sources', { client: { identifier: "yahoo", rootUrl: "http://yahoo.com" } }
    post '/sources/yahoo/data', { payload_request: {} }
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "We Need to Change this", last_response.body
  end
end
