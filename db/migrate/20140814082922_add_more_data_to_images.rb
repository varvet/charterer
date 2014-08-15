class AddMoreDataToImages < ActiveRecord::Migration
  def change
    add_column :images, :filter, :string
    add_column :images, :caption, :text
    add_column :images, :created_time, :datetime
  end
end
