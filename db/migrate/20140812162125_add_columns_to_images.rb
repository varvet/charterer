class AddColumnsToImages < ActiveRecord::Migration
  def change
    add_column :images, :remote_id, :string
    add_index :images, :remote_id, unique: true
    add_column :images, :url, :string
    add_column :images, :thumbnail, :string
    add_column :images, :user_id, :integer
  end
end
