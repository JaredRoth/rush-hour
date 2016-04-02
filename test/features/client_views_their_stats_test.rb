require_relative '../test_helper'

class ClientViewsTheirStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_client_can_view_their_stats
    create_payloads(4)

    visit '/sources/jumpstartlab'

    # test things

    # assert page.has_content? '1 name'
    #
    # click_link robots.all.last.id.to_s
    # click_button 'Remove Robot (but why?)'
    #
    # refute page.has_content? '1 name'
  end

  def test_client_sees_not_registered_error_page
    visit '/sources/jumpstartlab'

    # test things on the appropriate error page
  end

  def test_client_sees_no_payloads_error_page
    visit '/sources/jumpstartlab'

    # test things on the appropriate error page
  end
end
