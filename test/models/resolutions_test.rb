require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_resolutions
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
    create_resolutions

    assert_equal 3, Resolution.count
  end
end
