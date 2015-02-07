class CreateIdeaCompetencies < ActiveRecord::Migration
  def change
    create_table :idea_competencies do |t|

      t.references :idea
      t.references :competency

      t.timestamps

    end
  end
end
