class AddShaColumnToPayloadRequest < ActiveRecord::Migration
  def change
    add_column :payload_requests, :payload_sha, :text
  end
end
