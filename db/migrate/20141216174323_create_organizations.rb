class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|

      t.string :name
      t.string :shortname
      t.string :url

      t.timestamps

      t.index :name
      t.index :shortname

    end
  end
end
