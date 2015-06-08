class CreateProjectVotes < ActiveRecord::Migration
  def change
    create_table :project_votes do |t|

      t.references :project
      t.references :user

      t.boolean :participate, default: false

      t.timestamps

      t.index :created_at

    end
  end
end
