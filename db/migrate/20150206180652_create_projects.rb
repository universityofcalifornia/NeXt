class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.references :project_status

      t.string :name
      t.text :pitch
      t.text :description

      t.string :website_url
      t.string :documentation_url
      t.string :source_url
      t.string :download_url

      t.timestamps

      t.index :created_at

    end
  end
end
