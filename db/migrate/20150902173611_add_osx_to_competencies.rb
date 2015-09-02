class AddOsxToCompetencies < ActiveRecord::Migration
  def change
    Competency.create(:name => "OS X")
  end
end
