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

  describe "invites" do
    it "should call create_invites"do
      event = FactoryGirl.build(:event)
      event.should_receive(:create_invites)
      event.save!
    end

    it "should create invites" do
      event = FactoryGirl.create(:event, :invite_list => 'moo@moo.com, test@test.com')
      expect(event.invites.map(&:email)).to eq(['moo@moo.com','test@test.com'])
    end
  end

  context "validations and relationships" do
  	it { should belong_to(:user) }
    it { should have_many(:invites) }
    #xit { should have_many(:groups).through(:event_groups) }
    it { should validate_presence_of(:name) }
  end

end
