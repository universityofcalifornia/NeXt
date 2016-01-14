class AddBinaryImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :binary_image, :text, :limit=>500000
  end
end
