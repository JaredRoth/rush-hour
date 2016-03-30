require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_ips
    assert Ip.first.respond_to?(:ip)
    assert_equal "63.29.38.211", Ip.first.ip
    assert_equal "63.29.38.212", Ip.second.ip
    assert_equal "63.29.38.213", Ip.last.ip
  end

  def test_nil_does_not_get_created
    create_ips

    assert_equal 3, Ip.count
  end
end
