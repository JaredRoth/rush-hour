require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_payloads
    request = PayloadRequest.last

    assert request.respond_to?(:requested_at)
    assert request.respond_to?(:responded_in)
    assert request.respond_to?(:ip_id)
    assert request.respond_to?(:resolution_id)
    assert request.respond_to?(:user_agent_id)
    assert request.respond_to?(:event_id)
    assert request.respond_to?(:request_type_id)
    assert request.respond_to?(:referrer_id)
    assert request.respond_to?(:url_id)

    assert_equal 3, request.id
    assert_equal 37, request.responded_in
    # assert_equal "2013-02-16 21:38:28 -0700", request.requested_at
    assert_equal 1, request.ip_id
    assert_equal 1, request.resolution_id
    assert_equal 1, request.user_agent_id
    assert_equal 1, request.event_id
    assert_equal 1, request.request_type_id
    assert_equal 1, request.referrer_id
    assert_equal 1, request.url_id
  end

  def test_nil_payloads
    create_nil_payloads
    assert_nil PayloadRequest.first
  end
end
