class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :payment_type
      t.string :amount
      t.string :express_token
      t.string :express_payer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
