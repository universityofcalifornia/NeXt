class AddMissingProjectStatuses < ActiveRecord::Migration
  def change
    completed = ProjectStatus.find(3)
    completed.key = "completed"
    completed.name = "Successfully completed"
    completed.save

    deployed = ProjectStatus.find(4)
    deployed.key = "deployed"
    deployed.name = "Deployed"
    deployed.save

    abandoned = ProjectStatus.new
    abandoned.key = "abandoned"
    abandoned.name = "Abandoned"
    abandoned.save
  end
end
