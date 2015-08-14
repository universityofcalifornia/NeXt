class AddEngagementMeterDisplayToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :engagement_meter_display, :boolean, :default => false

    # By default, show campuses only
    campuses = ["UCB", "UCD", "UCI", "UCLA", "UCM", "UCR", "UCSD", "UCSF", "UCSB", "UCSC", "UC Hastings"] 
    Organization.where(shortname: campuses).update_all(engagement_meter_display: true)
  end
end
