require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_request_types
    assert RequestType.first.respond_to?(:request_type)
    assert_equal "GET", RequestType.first.request_type
    assert_equal "GET", RequestType.second.request_type
    assert_equal "POST", RequestType.last.request_type
  end

  def test_nil_does_not_get_created
    create_request_types

    assert_equal 3, RequestType.count
  end

  def test_finds_most_used_request
    create_request_types

    assert_equal "GET", RequestType.most_frequent
  end

  def test_lists_all_request_types
    create_request_types

    assert_equal ["GET", "POST"], RequestType.list_all_verbs
  end
end
