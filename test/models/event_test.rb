require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_events

    assert Event.first.respond_to?(:event_name)
    assert_equal "socialLogin", Event.first.event_name
    assert_equal "beginRegistration", Event.second.event_name
    assert_equal "thirdEvent", Event.third.event_name
  end

  def test_nil_does_not_get_created
    create_events

    assert_equal 3, Event.count
  end
end
