require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    request1 = RequestType.create(:request_type => "GET")
    request2 = RequestType.create(:request_type => "POST")

    assert request1.respond_to?(:request_type)

    assert_equal "GET", request1.request_type
    assert_equal "POST", request2.request_type
  end

  def test_nil_does_not_get_created
    RequestType.create(nil)

    assert_equal 0, RequestType.count
  end

  def test_finds_most_used_request_types
    create_payloads(3)

    assert_equal "GET", RequestType.most_frequent_request_types
  end

  def test_lists_all_request_types
    create_payloads(2)

    assert RequestType.list_all_verbs.include?("GET")
    assert RequestType.list_all_verbs.include?("POST")
  end
end
