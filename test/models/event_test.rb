require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    event1 = Event.find_or_create_by(:event_name => "socialLogin")
    # use locals to save return value
    Event.find_or_create_by(:event_name => "beginRegistration")
    Event.find_or_create_by(:event_name => "thirdEvent")

    assert Event.first.respond_to?(:event_name)

    assert_equal "socialLogin", Event.first.event_name
    assert_equal "beginRegistration", Event.second.event_name
    assert_equal "thirdEvent", Event.last.event_name
  end

  def test_nil_does_not_get_created
    Event.create(nil)

    assert_equal 0, Event.count
  end

  def test_sorts_events_most_to_least_received
    create_payloads
    assert_equal ["socialLogin", "beginRegistration", "thirdEvent"], Event.sort_most_received
  end
end
