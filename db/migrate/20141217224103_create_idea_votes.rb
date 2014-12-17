class CreateIdeaVotes < ActiveRecord::Migration
  def change
    create_table :idea_votes do |t|

      t.references :idea
      t.references :user

      t.boolean :participate, default: false

      t.timestamps

      t.index :created_at

    end
  end
end
