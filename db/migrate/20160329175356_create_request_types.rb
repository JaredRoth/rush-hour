class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.text :request_type
    end
  end
end
