class CreatePayloadRequest < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.text :url
      t.date :requested_at
      # t.datetime :requested_at
      t.integer :responded_in
      t.text :referred_by
      t.text :request_type
      t.integer :parameters
      t.text :event_name
      t.text :user_agent
      t.integer :resolution_width
      t.integer :resolution_height
      t.text :ip
    end
  end
end
