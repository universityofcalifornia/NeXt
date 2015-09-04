class UnescapeAnr < ActiveRecord::Migration
  def change
    # It's unnecessary to escape the ampersand in the database, Rails does it for us
    anr = Organization.find_by_shortname "ANR"
    if anr
      anr.name = "Agriculture & National Resources"
      anr.save
    end
  end
end
