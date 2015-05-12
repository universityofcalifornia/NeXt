require 'rails_helper'

describe Event do

	it "should create an event" do
		event  = FactoryGirl.create(:event)
		expect(event.name).to eql("My first event")
	end

end