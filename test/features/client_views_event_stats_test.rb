require_relative '../test_helper'

class ClientViewsEventStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_client_can_view_events_stats
    create_payloads(9)

    visit '/sources/yahoo'

    assert_equal '/sources/yahoo', current_path

    first(:link, "socialLogin").click

    assert_equal '/sources/yahoo/events/socialLogin', current_path

    within '.Jumbotron' do
      assert page.has_content? 'socialLogin'
    end

    within '.event_total_count' do
      assert page.has_content? '4'
    end

    within '.hourly_count' do
      assert page.has_content? '8 :'
      assert page.has_content? '2 : 2'
      assert page.has_content? '6 : 1'
    end
  end

  def test_client_sees_no_urls_error_page
    create_payloads(1)

    visit '/sources/jumpstartlab/events/create'

    assert_equal '/sources/jumpstartlab/events/create', current_path

    within '.error' do
      assert page.has_content? "Sorry, No Events Associated With Your Account. "
      assert page.has_content? "Click here to see your available events."
      assert page.has_link? "Click here to see your available events."
    end

    click_link("Click here to see your available events.")

    assert_equal '/sources/jumpstartlab', current_path
  end
end
