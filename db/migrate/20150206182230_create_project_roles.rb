class CreateProjectRoles < ActiveRecord::Migration
  def change
    create_table :project_roles do |t|

      t.references :project
      t.references :user

      t.boolean :founder, default: false
      t.boolean :admin, default: false

      t.timestamps

      t.index :created_at

    end
  end
end
