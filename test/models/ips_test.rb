require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    ip1 = Ip.create(:ip => "63.29.38.211")
    ip2 = Ip.create(:ip => "63.29.38.212")
    ip3 = Ip.create(:ip => "63.29.38.213")

    assert ip1.respond_to?(:ip)

    assert_equal "63.29.38.211", ip1.ip
    assert_equal "63.29.38.212", ip2.ip
    assert_equal "63.29.38.213", ip3.ip
  end

  def test_nil_does_not_get_created
    Ip.create(nil)

    assert_equal 0, Ip.count
  end
end
