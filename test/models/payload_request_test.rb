require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  def test_responds_to_table_header
    request = PayloadRequest.new
    assert request.respond_to?(:requested_at)
  end
end
