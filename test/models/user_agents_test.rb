require_relative '../test_helper'

class UserAgentStringTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15")
    UserAgentString.create(:user_agent_string => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.16")

    assert UserAgentString.first.respond_to?(:user_agent_string)
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      UserAgentString.first.user_agent_string
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15",
      UserAgentString.second.user_agent_string
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.16",
      UserAgentString.last.user_agent_string
  end

  def test_nil_does_not_get_created
    UserAgentString.create(nil)

    assert_equal 0, UserAgentString.count
  end

  def test_browser_breakdown
    create_payloads

    assert_equal ["Chrome"], UserAgentString.browser_breakdown
  end

  def test_operating_system_breakdown
    create_payloads

    assert_equal ["Macintosh"], UserAgentString.operating_system_breakdown
  end
end
