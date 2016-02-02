class AddProfileImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_image, :text, :limit=>300000
  end
end
