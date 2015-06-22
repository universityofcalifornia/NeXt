class CreateProjectDocuments < ActiveRecord::Migration
  def change
    create_table :project_documents do |t|

      t.references :project

      t.string :filename
      t.text :description

      t.timestamps

    end
  end
end
