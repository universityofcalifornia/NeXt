class RemoveDupeAddUniqueIndex < ActiveRecord::Migration
  def change
    while Competency.where(:name => "OS X").count > 1
      dupe = Competency.where(:name => "OS X").max
      dupe.destroy
    end

    remove_index :competencies, :name
    add_index :competencies, :name, :unique => true
  end
end
