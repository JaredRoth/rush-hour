require_relative '../test_helper'

class ClientViewsTheirStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_client_can_view_their_stats
    create_payloads(5)

    visit '/sources/yahoo'

    within 'h1' do
      assert page.has_content? 'Yahoo'
    end

    within '.avg' do
      assert page.has_content? '37.67'
    end

    within '.max_time' do
      assert page.has_content? '39'
    end

    within '.min_time' do
      assert page.has_content? '36'
    end

    within '.max_request' do
      assert page.has_content? 'GET'
    end

    within '.requests' do
      assert page.has_content? 'GET'
      assert page.has_content? 'POST'
    end

    within '.urls' do
      assert page.has_content? 'http://yahoo.com/about'
      assert page.has_content? 'http://jumpstartlab.com/blog'
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
      assert page.has_content? '1920x1280'
    end
  end

  def test_client_sees_not_registered_error_page
    visit '/sources/jumpstartlab'

    within '.error' do
      assert page.has_content? "There is no account registered under this name."
      assert page.has_content? "Please register via curl request before proceeding."
    end
  end

  def test_client_sees_no_payloads_error_page
    Client.create(identifier: 'jumpstartlab', rootUrl: "http://yahoo.com")
    visit '/sources/jumpstartlab'

    within '.error' do
      assert page.has_content? "There are no payloads recorded for your account."
      assert page.has_content? "Please submit payloads via curl request to populate these statistics."
    end
  end
end
