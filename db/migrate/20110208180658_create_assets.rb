class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :Purchase_Order_Number
      t.integer :Request_Number
      t.date :Order_Date
      t.string :Location
      t.text :Description
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
