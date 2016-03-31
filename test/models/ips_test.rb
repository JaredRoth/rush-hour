require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    Ip.create(:ip => "63.29.38.211")
    Ip.create(:ip => "63.29.38.212")
    Ip.create(:ip => "63.29.38.213")

    assert Ip.first.respond_to?(:ip)

    assert_equal "63.29.38.211", Ip.first.ip
    assert_equal "63.29.38.212", Ip.second.ip
    assert_equal "63.29.38.213", Ip.last.ip
  end

  def test_nil_does_not_get_created
    Ip.create(nil)

    assert_equal 0, Ip.count
  end
end
