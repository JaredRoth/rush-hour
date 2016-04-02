require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    event1 = Event.find_or_create_by(:event_name => "socialLogin")
    event2 = Event.find_or_create_by(:event_name => "beginRegistration")
    event3 = Event.find_or_create_by(:event_name => "thirdEvent")

    assert event1.respond_to?(:event_name)

    assert_equal "socialLogin", event1.event_name
    assert_equal "beginRegistration", event2.event_name
    assert_equal "thirdEvent", event3.event_name
  end

  def test_nil_does_not_get_created
    Event.create(nil)

    assert_equal 0, Event.count
  end

  def test_sorts_events_most_to_least_received
    create_payloads(6)

    assert_equal ["thirdEvent", "beginRegistration", "socialLogin"], Event.sort_most_received
  end

  def test_returns_hash_of_hourly_data
    create_payloads(9)

    event = Event.find_by(event_name: 'thirdEvent')
    times = {3.0=>1, 4.0=>1, 6.0=>1}

    assert_equal times, event.hourly_requests
  end

  def test_returns_total_count_events
    create_payloads(6)

  end
end
