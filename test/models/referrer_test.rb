require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    referrer = create_referrers
    assert referrer.respond_to?(:referred_by)
    assert_equal "http://jumpstartlab.com", referrer.referred_by
  end
end
