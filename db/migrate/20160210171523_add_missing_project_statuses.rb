class AddMissingProjectStatuses < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("TRUNCATE `project_statuses`;")
    ProjectStatus.create([
      { key: 'forming',   name: 'Forming - recruiting resources', icon: '' },
      { key: 'active',    name: 'Active - fully resourced',       icon: '' },
      { key: 'completed', name: 'Successfully completed',         icon: '' },
      { key: 'deployed',  name: 'Deployed',                       icon: '' },
      { key: 'abandoned', name: 'Abandoned',                      icon: '' }
    ])
  end
end
