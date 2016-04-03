require_relative '../test_helper'

class UserAgentStringTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    user_agent_string1 = UserAgentString.create(:user_agent_os => "Macintosh", :user_agent_browser => "Chrome")
    user_agent_string2 = UserAgentString.create(:user_agent_os => "Windows", :user_agent_browser => "Firefox")

    assert user_agent_string1.respond_to?(:user_agent_os)
    assert user_agent_string1.respond_to?(:user_agent_browser)

    assert_equal "Macintosh", user_agent_string1.user_agent_os
    assert_equal "Windows",user_agent_string2.user_agent_os

    assert_equal "Chrome", user_agent_string1.user_agent_browser
    assert_equal "Firefox",user_agent_string2.user_agent_browser
  end

  def test_nil_does_not_get_created
    UserAgentString.create(nil)

    assert_equal 0, UserAgentString.count
  end

  def test_browser_breakdown
    create_payloads(3)

    assert_equal ["Chrome", "Safari", "Firefox"], UserAgentString.browser_breakdown
  end

  def test_operating_system_breakdown
    create_payloads(2)

    assert_equal ["Windows", "Macintosh"], UserAgentString.operating_system_breakdown
  end
end
