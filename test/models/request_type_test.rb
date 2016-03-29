require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    request_type = create_request_types
    assert request_type.respond_to?(:request_type)
    assert_equal "GET", request_type.request_type
  end
end
