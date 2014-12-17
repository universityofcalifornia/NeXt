class CreateIdeaRoles < ActiveRecord::Migration
  def change
    create_table :idea_roles do |t|

      t.references :idea
      t.references :user

      t.boolean :founder, default: false
      t.boolean :admin, default: false

      t.timestamps

      t.index :created_at

    end
  end
end
