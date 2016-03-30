require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    create_user_agents
    assert UserAgent.first.respond_to?(:user_agent)
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      UserAgent.first.user_agent
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.15",
      UserAgent.second.user_agent
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.16",
      UserAgent.last.user_agent
  end

  def test_nil_does_not_get_created
    create_user_agents

    assert_equal 3, UserAgent.count
  end
end
