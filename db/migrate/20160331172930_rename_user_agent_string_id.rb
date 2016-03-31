class RenameUserAgentStringId < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :user_agent_id, :integer
    add_column :payload_requests, :user_agent_string_id, :integer
  end
end
