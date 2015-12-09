class AddSponsorAndManagerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sponsor, :string
    add_column :projects, :manager, :string
  end
end
