class AlterPayloadRequests < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :url, :text
    remove_column :payload_requests, :referred_by, :text
    remove_column :payload_requests, :request_type, :text
    remove_column :payload_requests, :parameters, :integer
    remove_column :payload_requests, :event_name, :text
    remove_column :payload_requests, :user_agent, :text
    remove_column :payload_requests, :resolution_height, :integer
    remove_column :payload_requests, :resolution_width, :integer
    remove_column :payload_requests, :ip, :text

    add_column :payload_requests, :url_id, :integer
    add_column :payload_requests, :referrer_id, :integer
    add_column :payload_requests, :request_type_id, :integer
    add_column :payload_requests, :event_id, :integer
    add_column :payload_requests, :user_agent_id, :integer
    add_column :payload_requests, :resolution_id, :integer
    add_column :payload_requests, :ip_id, :integer
  end
end
