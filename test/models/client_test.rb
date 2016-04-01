require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    client1 = Client.create(:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com")
    client2 = Client.create(:identifier => "yahoo", :rootUrl => "http://yahoo.com")
    client3 = Client.create(:identifier => "apple", :rootUrl => "http://apple.com")

    assert client1.respond_to?(:identifier)
    assert client1.respond_to?(:rootUrl)

    assert_equal "jumpstartlab", client1.identifier
    assert_equal "http://jumpstartlab.com", client1.rootUrl

    assert_equal "yahoo", client2.identifier
    assert_equal "http://yahoo.com", client2.rootUrl

    assert_equal "apple", client3.identifier
    assert_equal "http://apple.com", client3.rootUrl
  end

  def test_nil_does_not_get_created
    Client.create(nil)

    assert_equal 0, Client.count
  end
end
