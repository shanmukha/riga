class CreateBuyers < ActiveRecord::Migration
  def self.up
    create_table :buyers do |t|
      t.string :name
      t.string :ip_address
      t.string :email
      t.string :guide_token
      t.integer :order_id
      t.timestamps
    end
  end

  def self.down
    drop_table :buyers
  end
end
