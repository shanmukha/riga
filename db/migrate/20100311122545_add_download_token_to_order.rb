class AddDownloadTokenToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :download_token, :string
  end

  def self.down
    remove_column :orders, :download_token, :string
  end
end

