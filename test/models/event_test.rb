require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    event = create_events
    assert event.respond_to?(:event_name)
    assert_equal "socialLogin", event.event_name
  end
end
