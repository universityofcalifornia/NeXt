class DisplayAllOrganizationsOnEngagementMeter < ActiveRecord::Migration
  def change
    Organization.update_all(engagement_meter_display: true)
  end
end
