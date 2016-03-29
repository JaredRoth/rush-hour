class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :referred_by
    end
  end
end
