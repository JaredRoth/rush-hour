require_relative '../test_helper'

class ClientViewsUrlStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_client_can_view_urls_stats
    create_payloads(7)

    visit '/sources/jumpstartlab/urls/blog'

    within 'h1' do
      assert page.has_content? 'jumpstartlab'
    end

    within '.avg_time' do
      # save_and_open_page
      assert page.has_content? '37.33'
    end

    within '.max_time' do
      assert page.has_content? '39'
    end

    within '.min_time' do
      assert page.has_content? '35'
    end

    within '.requests' do
      assert page.has_content? 'POST'
      assert page.has_content? 'GET'
    end

    within '.ordered_response_times' do
      assert page.has_content? '39, 38, 35'
    end

    within '.referrers' do
      assert page.has_content? 'http://jumpstartlab.com'
      assert page.has_content? 'http://google.com'
    end

    within '.user_agents' do
      assert page.has_content? 'Chrome, Macintosh'
      assert page.has_content? 'Safari, Windows'
      assert page.has_content? 'Chrome, Windows'
    end
  end

  def test_client_sees_no_urls_error_page
    Client.create(identifier: 'jumpstartlab', rootUrl: "http://jumpstartlab.com")
    visit '/sources/jumpstartlab/urls/blog'

    within '.error' do
      assert page.has_content? "Sorry, this Url is not associated with your account"
    end
  end
end
