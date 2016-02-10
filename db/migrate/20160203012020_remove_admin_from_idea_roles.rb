class RemoveAdminFromIdeaRoles < ActiveRecord::Migration
  def change
    remove_column :idea_roles, :admin, :boolean
  end
end
