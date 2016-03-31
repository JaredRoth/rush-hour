require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    Resolution.create(:resolution_width => "1920", :resolution_height => "1280")
    Resolution.create(:resolution_width => "800", :resolution_height => "600")
    Resolution.create(:resolution_width => "720", :resolution_height => "500")

    assert Resolution.first.respond_to?(:resolution_width)
    assert Resolution.first.respond_to?(:resolution_height)
    
    assert_equal 1920, Resolution.first.resolution_width
    assert_equal 1280, Resolution.first.resolution_height

    assert_equal 800, Resolution.second.resolution_width
    assert_equal 600, Resolution.second.resolution_height

    assert_equal 720, Resolution.last.resolution_width
    assert_equal 500, Resolution.last.resolution_height
  end

  def test_nil_does_not_get_created
    Resolution.create(nil)

    assert_equal 0, Resolution.count
  end

  def test_displays_all_resolutions
    create_payloads

    assert Resolution.list_resolutions.include?("720x500")
    assert Resolution.list_resolutions.include?("800x600")
    assert Resolution.list_resolutions.include?("1920x1280")
  end
end
