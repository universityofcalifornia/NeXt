require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment) }

  context "relationships" do
    
  	it { should belong_to(:user) }
    it { should belong_to(:ideas) }

  end

end
