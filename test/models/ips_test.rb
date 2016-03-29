require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    ip = create_ips
    assert ip.respond_to?(:ip)
    assert_equal "63.29.38.211", ip.ip
  end
end
