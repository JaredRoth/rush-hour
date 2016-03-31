require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_headers
    create_payloads
    request = PayloadRequest.first

    assert request.respond_to?(:requested_at)
    assert request.respond_to?(:responded_in)
    assert request.respond_to?(:ip_id)
    assert request.respond_to?(:resolution_id)
    assert request.respond_to?(:user_agent_id)
    assert request.respond_to?(:event_id)
    assert request.respond_to?(:request_type_id)
    assert request.respond_to?(:referrer_id)
    assert request.respond_to?(:url_id)

    assert_equal 1, request.id
    assert_equal 36, request.responded_in
    assert_equal DateTime.parse("2013-02-16 21:38:28 -0700"), request.requested_at
    assert_equal 1, request.ip_id
    assert_equal 1, request.resolution_id
    assert_equal 1, request.user_agent_id
    assert_equal 1, request.event_id
    assert_equal 1, request.request_type_id
    assert_equal 1, request.referrer_id
    assert_equal 1, request.url_id
  end

  def test_nil_payloads
    PayloadRequest.create(:requested_at => nil,
                          :responded_in => nil,
                          :ip_id => nil,
                          :resolution_id => nil,
                          :user_agent_id => nil,
                          :event_id => nil,
                          :request_type_id => nil,
                          :referrer_id => nil,
                          :url_id => nil
                          )

    assert_nil PayloadRequest.first
    assert_equal 0, PayloadRequest.count
  end

  def test_returns_correct_response_time_average
    create_payloads
    assert_equal 37, PayloadRequest.avg_response_time
  end

  def test_returns_highest_response_time
    create_payloads
    assert_equal 38, PayloadRequest.max_response_time
  end

  def test_returns_lowest_response_time
    create_payloads
    assert_equal 36, PayloadRequest.min_response_time
  end
end
