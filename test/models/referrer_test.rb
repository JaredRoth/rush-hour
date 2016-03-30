require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_referrers
    assert Referrer.first.respond_to?(:referred_by)
    assert_equal "http://jumpstartlab.com", Referrer.first.referred_by
    assert_equal "http://yahoo.com", Referrer.second.referred_by
    assert_equal "http://apple.com", Referrer.third.referred_by
  end

  def test_nil_does_not_get_created
    create_referrers

    assert_equal 3, Referrer.count
  end
end
