require './test/test_helper'

class ReceivePayloadTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_create_a_payload_with_valid_attributes
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    post '/sources/yahoo/data', { payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211" }' }
    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Your submission was successful. ", last_response.body
  end

  def test_cannot_create_a_payload_that_already_exists
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    post '/sources/yahoo/data', { payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211" }' }
    assert_equal 1, PayloadRequest.count
    post '/sources/yahoo/data', { payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211" }' }
    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Payload sha has already been taken. ", last_response.body
  end

  def test_cannot_create_a_payload_with_unknown_identifier
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    post '/sources/jumpstart/data', { payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211" }' }
    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Client is not registered. ", last_response.body
  end

  def test_cannot_create_a_payload_without_payload
    post '/sources', { identifier: "yahoo", rootUrl: "http://yahoo.com" }
    post '/sources/yahoo/data'
    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Requested at can't be blank, Responded in can't be blank, Payload sha can't be blank, Url can't be blank, Referrer can't be blank, Request type can't be blank, Event can't be blank, User agent string can't be blank, Resolution can't be blank, Ip can't be blank. ",
        last_response.body
  end
end
