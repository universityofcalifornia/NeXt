require 'test_helper'

class PositionTest < ActiveSupport::TestCase

  test 'paranoid' do

    assert Position.respond_to? :only_deleted

  end

  test 'relation existence' do

    position = Position.new
    assert position.respond_to? :user
    assert position.respond_to? :user=
    assert position.respond_to? :organization
    assert position.respond_to? :organization=

  end

end
