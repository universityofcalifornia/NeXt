require 'rails_helper'

describe Event do

  before(:all) do
    @event  = FactoryGirl.create(:event)
  end

  xit "should validate map_url if present" do
    @event.map_url = nil
    p @event
    expect{ @event.save! }.to raise_error
  end

	it { should belong_to(:user) }
  it { should validate_presence_of(:name) }


end