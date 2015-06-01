require 'rails_helper'

describe EventGroup do
  context "relationships" do
    it { should belong_to(:event) }
    it { should belong_to(:group) }
  end
end
