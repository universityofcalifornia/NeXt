require 'rails_helper'

describe Invite do
  it { should belong_to(:event) }

end
