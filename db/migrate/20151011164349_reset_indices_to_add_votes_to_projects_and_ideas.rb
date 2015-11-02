class ResetIndicesToAddVotesToProjectsAndIdeas < ActiveRecord::Migration
  def change

    [
        { name: 'idea', class: Idea, label: :name },
        { name: 'project', class: Project, label: :name },
        { name: 'user', class: User, label: :display_name }
    ].each do |o|
      o[:class].all.each do |obj|
        if obj.index_exists?
          puts "[#{o[:name]} - reset index - #{obj.id}] #{obj.send(o[:label])}"
          obj.destroy_index!
        end
        puts "[#{o[:name]} - create index - #{obj.id}] #{obj.send(o[:label])}"
        obj.create_index!
      end
    end


  end
end
