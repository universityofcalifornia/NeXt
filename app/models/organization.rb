class Organization < ActiveRecord::Base

  acts_as_paranoid

  has_many :positions
  has_many :users, through: :positions

  def engagement_points(type = :all)
    return case type
    when :ideas
      idea_points
    when :projects
      project_points
    when :other
      other_points
    else
      idea_points + project_points + other_points
    end
  end

  def engagement_points_percent(type = :all)
    return 0 if Organization.engagement_points_max(type) == 0
    return (engagement_points(type).to_f / Organization.engagement_points_max(type) * 100).round
  end

  def self.engagement_points_max(type = :all)
    @engagement_points_max ||= {}

    # Cache the points to avoid calculating again
    unless @engagement_points_max.has_key? type
      orgs = type == :full_list ? Organization : Organization.where(engagement_meter_display: true)
      @engagement_points_max[type] = orgs.maximum(
        case type
        when :ideas
          :idea_points
        when :projects
          :project_points
        when :other
          :other_points
        else
          "idea_points + project_points + other_points"
        end
      )
    end

    return @engagement_points_max[type]
  end

end
