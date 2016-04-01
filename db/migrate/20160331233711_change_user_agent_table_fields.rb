class ChangeUserAgentTableFields < ActiveRecord::Migration
  def change
    remove_column :user_agent_strings, :user_agent_string, :text

    add_column :user_agent_strings, :user_agent_os, :text
    add_column :user_agent_strings, :user_agent_browser, :text
  end
end
