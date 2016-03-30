class ChangePayloadRequestColumnRequestedAtToDatetime < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :requested_at, :date

    add_column :payload_requests, :requested_at, :datetime
  end
end
