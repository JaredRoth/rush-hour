require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers
  def test_responds_to_table_header
    user_agent = create_user_agents
    assert user_agent.respond_to?(:user_agent)
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      user_agent.user_agent
  end
end
