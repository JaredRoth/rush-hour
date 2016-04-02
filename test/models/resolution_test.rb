require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    res1 = Resolution.create(:resolution_width => "1920", :resolution_height => "1280")
    res2 = Resolution.create(:resolution_width => "800", :resolution_height => "600")
    res3 = Resolution.create(:resolution_width => "720", :resolution_height => "500")

    assert res1.respond_to?(:resolution_width)
    assert res1.respond_to?(:resolution_height)

    assert_equal 1920, res1.resolution_width
    assert_equal 1280, res1.resolution_height

    assert_equal 800, res2.resolution_width
    assert_equal 600, res2.resolution_height

    assert_equal 720, res3.resolution_width
    assert_equal 500, res3.resolution_height
  end

  def test_nil_does_not_get_created
    Resolution.create(nil)

    assert_equal 0, Resolution.count
  end

  def test_displays_all_resolutions
    create_payloads(3)

    resolutions = Resolution.list_resolutions

    ["720x500", "800x600", "1920x1280"].each do |res|
      assert resolutions.include?(res)
    end
  end
end
