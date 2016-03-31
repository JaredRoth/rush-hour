require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    Referrer.create(:referred_by => "http://jumpstartlab.com")
    Referrer.create(:referred_by => "http://yahoo.com")
    Referrer.create(:referred_by => "http://apple.com")

    assert Referrer.first.respond_to?(:referred_by)
    
    assert_equal "http://jumpstartlab.com", Referrer.first.referred_by
    assert_equal "http://yahoo.com", Referrer.second.referred_by
    assert_equal "http://apple.com", Referrer.third.referred_by
  end

  def test_nil_does_not_get_created
    Referrer.create(nil)

    assert_equal 0, Referrer.count
  end
end
