class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|

      t.string :name
      t.timestamps

      t.index :name

    end
  end
end
