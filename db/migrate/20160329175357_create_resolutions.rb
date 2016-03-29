class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :resolution_width
      t.integer :resolution_height
    end
  end
end
