require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    referrer1 = Referrer.create(:referred_by => "http://jumpstartlab.com")
    referrer2 = Referrer.create(:referred_by => "http://yahoo.com")
    referrer3 = Referrer.create(:referred_by => "http://apple.com")

    assert referrer1.respond_to?(:referred_by)

    assert_equal "http://jumpstartlab.com", referrer1.referred_by
    assert_equal "http://yahoo.com", referrer2.referred_by
    assert_equal "http://apple.com", referrer3.referred_by
  end

  def test_nil_does_not_get_created
    Referrer.create(nil)

    assert_equal 0, Referrer.count
  end
end
