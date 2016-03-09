class RemoveHiddenFromPrivacies < ActiveRecord::Migration
  def change
    remove_column :privacies, :hidden, :boolean
  end
end
