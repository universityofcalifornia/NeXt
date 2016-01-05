class MakeCommentsPolymorphic < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
    end
    add_index :comments, [:commentable_id,:commentable_type]

    execute("UPDATE comments SET commentable_id = idea_id, commentable_type = 'Idea'")

    remove_column :comments, :idea_id
    
  end
end
