require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }  

  pending "Test nested relationships"

  context "validations and relationships" do
    it { should belong_to(:user) }

    it { should validate_presence_of(:body) }
  end

end
