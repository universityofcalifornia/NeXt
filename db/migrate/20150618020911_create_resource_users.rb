class CreateResourceUsers < ActiveRecord::Migration
  def change
    create_table :resource_users do |t|

      t.references :resource
      t.references :user
      t.timestamps

    end
  end
end
