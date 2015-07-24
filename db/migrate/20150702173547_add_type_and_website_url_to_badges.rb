class AddTypeAndWebsiteUrlToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :type,        :string
    add_column :badges, :website_url, :string
  end
end
