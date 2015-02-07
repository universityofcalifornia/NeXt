class CreateProjectCompetencies < ActiveRecord::Migration
  def change
    create_table :project_competencies do |t|

      t.references :project
      t.references :competency

      t.timestamps

    end
  end
end
