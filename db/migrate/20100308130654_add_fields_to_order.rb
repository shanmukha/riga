class AddFieldsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :payer_id, :string
    add_column :orders, :transaction_id, :string
    remove_column :orders, :express_token
    remove_column :orders, :express_payer_id
  end

  def self.down
    remove_column :orders, :payer_id
    remove_column :orders, :transaction_id
    add_column :orders, :express_token, :string
    add_column :orders, :express_payer_id, :string
  end
end
