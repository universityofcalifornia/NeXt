require 'rails_helper'

describe Event do
  context "invalid url's" do

    it "should validate map_url if present" do
      bad_map_url  = FactoryGirl.build(:event, :map_url => 'moo')
      expect(bad_map_url).to be_invalid
    end

    it "should validate event_url if present" do
      bad_event_url  = FactoryGirl.build(:event, :event_url => 'moo')
      expect(bad_event_url).to be_invalid
    end
  end

  context "validations and relationships" do
  	it { should belong_to(:user) }
    it {should have_many(:invites)}
    it { should validate_presence_of(:name) }
  end

end
