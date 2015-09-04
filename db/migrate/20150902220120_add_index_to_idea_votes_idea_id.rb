class AddIndexToIdeaVotesIdeaId < ActiveRecord::Migration
  def change
    add_index :idea_votes, :idea_id
  end
end
