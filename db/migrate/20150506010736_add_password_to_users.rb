class AddPasswordToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :password_hash, default: nil
    end
  end
end
