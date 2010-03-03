class CreateSettingTable < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.decimal :price , :precision => 10, :scale => 2
      t.string :setting_pdf_file_name
      t.string :setting_pdf_content_type
      t.integer :setting_pdf_file_size
      t.timestamps
    end
  end

  def self.down
  end
end

