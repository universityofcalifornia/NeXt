require 'rails_helper'

describe Event do
  let(:event) { build(:event) }

  context "invalid url's" do
    it "should validate map_url if present" do
      event.map_url = 'moo'
      expect(event).to be_invalid
    end

    it "should validate event_url if present" do
      event.event_url = 'moo'
      expect(event).to be_invalid
    end
  end

  describe "invites" do
    it "should call create_invites"do
      expect(event).to receive(:create_invites)
      event.save!
    end

    it "should create invites" do
      event = create(:event, :invite_list => 'moo@moo.com, test@test.com')
      expect(event.invites.map(&:email)).to eq(['moo@moo.com','test@test.com'])
    end

    it "should create groups" do
      event = create(:event, :name => 'moo')
      group1 = event.groups.create(:name => 'moo@moo.com')
      group2 = event.groups.create( :name => 'test@test.com')
      event.group_tokens = ("#{group1.id},#{group2.id}")
      expect(event.groups.map(&:name)).to eq(['moo@moo.com', 'test@test.com'])
    end
  end

  context "validations and relationships" do
    it { should belong_to(:user) }
    it { should have_many(:invites) }
    #xit { should have_many(:groups).through(:event_groups) }
    it { should validate_presence_of(:name) }
  end

end
