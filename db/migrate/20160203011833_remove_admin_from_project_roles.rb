class RemoveAdminFromProjectRoles < ActiveRecord::Migration
  def change
    remove_column :project_roles, :admin, :boolean
  end
end
