require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    request1 = RequestType.create(:request_type => "GET")
    # save as locals
    RequestType.create(:request_type => "POST")

    assert RequestType.first.respond_to?(:request_type)

    assert_equal "GET", RequestType.first.request_type
    assert_equal "POST", RequestType.last.request_type
  end

  def test_nil_does_not_get_created
    RequestType.create(nil)

    assert_equal 0, RequestType.count
  end

  def test_finds_most_used_request
    create_payloads

    assert_equal "GET", RequestType.most_frequent
  end

  def test_lists_all_request_types
    create_payloads

    assert_equal ["GET", "POST"], RequestType.list_all_verbs
  end
end
