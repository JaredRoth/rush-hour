class ChangeUserAgentClassToUserAgentString < ActiveRecord::Migration
  def change
    rename_table :user_agents, :user_agent_strings
    rename_column :user_agent_strings, :user_agent, :user_agent_string
  end
end
