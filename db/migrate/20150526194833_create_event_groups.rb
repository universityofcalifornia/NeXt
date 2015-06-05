class CreateEventGroups < ActiveRecord::Migration
  def change
    create_table :event_groups do |t|
      t.integer :event_id
      t.integer :group_id

      t.timestamps
    end
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end
    Group.reset_column_information
    EventGroup.reset_column_information

    add_foreign_key(:event_groups, :events)
    add_foreign_key(:event_groups, :groups)

    reversible do |dir|
      dir.up do
        add_index :event_groups, [:event_id, :group_id]
        add_index :event_groups, :event_id
        add_index :groups, :name, :unique => true



        groups = ['financial applications developers', 'java developers', 'java spring security', 'mysql developers',
            'database developers', 'informatica', 'identity management', 'network security']

        groups.each do |group|
          Group.create(:name => group)
        end
      end
    end

  end
end
