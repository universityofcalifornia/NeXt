require 'rails_helper'

describe Invite do
  it { should belong_to(:event) }

  it "should bring back all that have not responded" do
    create(:invite, :responded =>  false)
    expect(Invite.all_that_have_not_responded.count).to eql(1)
  end

end
