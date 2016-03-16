module OrganizationsHelper
  def logo_path object
    if object.organizations.blank?
      filename = "UC-Wide"
    elsif object.organizations.count > 1
      filename = "multi-campus"
    else
      filename = object.organizations.first.name
    end

    "/images/organizations/#{filename}.png"
  end
end
