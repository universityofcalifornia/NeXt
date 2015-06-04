class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references 	:user
      t.string 			:name
			t.string 			:description
			t.date				:start_date
			t.date				:stop_date
			t.time				:start_time
			t.time				:stop_time
			t.string			:location
			t.string			:event_url
			t.string			:map_url
			t.integer			:number_going
			t.integer			:number_invited



      t.timestamps
    end

    add_index :events, :user_id

  end
end
