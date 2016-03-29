require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    request = create_payloads
    assert request.respond_to?(:requested_at)
    # assert_equal "2013-02-16 21:38:28 -0700", request.requested_at
    assert_equal 37, request.responded_in
  end
end
