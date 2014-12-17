class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|

      t.references :idea_status

      t.string :name
      t.text :pitch
      t.text :description

      t.timestamps

      t.index :created_at

    end
  end
end
