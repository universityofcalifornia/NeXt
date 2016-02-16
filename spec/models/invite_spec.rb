require 'rails_helper'

describe Invite do
  it { should belong_to(:event) }

  it "should bring back all that have not responded" do
    create(:invite, :email_sent =>  false)
    expect(Invite.not_yet_invited.count).to eql(1)
  end

end
