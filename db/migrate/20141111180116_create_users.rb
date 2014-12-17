class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.text :email, null: false

      t.integer :primary_position_id

      t.string :name_first
      t.string :name_middle
      t.string :name_last, null: false
      t.string :name_suffix

      t.string :website
      t.string :phone_number
      t.string :fax_number
      t.text :mailing_address

      t.text :biography

      t.string :social_google
      t.string :social_github
      t.string :social_linkedin
      t.string :social_twitter

      t.boolean :super_admin, :default => false

      t.timestamps

      t.index [:name_last, :name_first, :name_middle, :name_suffix], :name => 'name'
      t.index :primary_position_id
      t.index :super_admin
      t.index :created_at

    end
  end
end
