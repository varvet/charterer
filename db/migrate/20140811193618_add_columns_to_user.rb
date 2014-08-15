class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :image, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :website, :string
  end
end
