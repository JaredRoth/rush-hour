require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    resolution = create_resolutions
    assert resolution.respond_to?(:resolution_width)
    assert resolution.respond_to?(:resolution_height)
    assert_equal 1920, resolution.resolution_width
    assert_equal 1280, resolution.resolution_height
  end
end
