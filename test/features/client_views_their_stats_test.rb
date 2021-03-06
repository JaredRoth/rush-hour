require_relative '../test_helper'

class ClientViewsTheirStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_client_can_view_their_stats
    create_payloads(5)

    visit '/sources/yahoo'

    assert_equal '/sources/yahoo', current_path

    within 'h1' do
      assert page.has_content? 'Yahoo'
    end

    within '.avg' do
      assert page.has_content? '37.0'
    end

    within '.max_time' do
      assert page.has_content? '38'
    end

    within '.min_time' do
      assert page.has_content? '36'
    end

    within '.max_request' do
      assert page.has_content? 'GET'
    end

    within '.requests' do
      assert page.has_content? 'GET'
    end

    within '.urls' do
      assert page.has_content? 'http://yahoo.com/blog'
      assert page.has_content? 'http://yahoo.com/about'
    end

    within '.browsers' do
      assert page.has_content? 'Safari'
    end

    within '.os' do
      assert page.has_content? 'Macintosh'
      assert page.has_content? 'Windows'
    end

    within '.res' do
      assert page.has_content? '720x500'
      assert page.has_content? '800x600'
    end
  end

  def test_client_sees_not_registered_error_page
    visit '/sources/jumpstartlab'

    assert_equal '/sources/jumpstartlab', current_path

    within '.error' do
      assert page.has_content? "Sorry, no account registered under this name."
      assert page.has_content? "Please register via curl request before proceeding. "
    end
  end

  def test_client_sees_no_payloads_error_page
    Client.create(identifier: 'jumpstartlab', rootUrl: "http://yahoo.com")
    visit '/sources/jumpstartlab'

    assert_equal '/sources/jumpstartlab', current_path

    within '.error' do
      assert page.has_content? "Sorry, no payloads associated with your account."
      assert page.has_content? "Please submit payloads via curl request to populate these statistics. "
    end
  end
end
