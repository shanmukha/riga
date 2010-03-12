class AddStatusToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :string
  end

  def self.down
     remove_column :orders, :status, :string
  end
end

