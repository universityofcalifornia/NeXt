class CreatePrivacies < ActiveRecord::Migration
  def change
    create_table :privacies do |t|
      t.references :privacy_options, polymorphic: true, index: true
      t.references :organization, index: true
      t.boolean :hidden, default: false
      t.timestamps
    end
  end
end
