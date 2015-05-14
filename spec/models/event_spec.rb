require 'rails_helper'

describe Event do

	it "should create an event" do
		event  = FactoryGirl.create(:event)
		expect(event.name).to eql("My first event")
	end

	it { should belong_to(:user) }
  it { should validate_presence_of(:name) }

end