class CreateCompetencyUsers < ActiveRecord::Migration
  def change
    create_table :competency_users do |t|

      t.references :competency
      t.references :user
      t.timestamps

    end
  end
end
