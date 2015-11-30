require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'relation existence' do

    user = User.new
    assert user.respond_to? :oauth2_identities
    assert user.respond_to? :oauth2_identities=
    assert user.respond_to? :positions
    assert user.respond_to? :positions=
    assert user.respond_to? :organizations
    assert user.respond_to? :organizations=

  end

  test 'oauth2_identity relation' do

    user = User.find(1)

    assert_equal Oauth2Identity.find(1).user_id, 1
    assert_equal Oauth2Identity.find(2).user_id, 1

    assert_not_nil user.oauth2_identities
    assert user.oauth2_identities.ids.include? 1
    assert user.oauth2_identities.ids.include? 2

  end

  test 'position relation' do

    user = User.find(1)

    assert user.respond_to? :positions

    count = user.positions.count
    user.positions << Position.new(title: 'Pos', department: 'Dept')
    user.save

    assert_not_nil user.positions
    assert_equal user.positions.count, count + 1
    assert_equal user.positions.last.title, 'Pos'

    user.positions.last.delete
    assert_equal user.positions.count, count

  end

  test 'organization relation' do

    user = User.find(1)
    organization = Organization.find(1)

    old_positions = user.position_ids
    user.positions = []
    user.save

    assert_equal user.positions.count, 0
    user.positions << Position.new(title: 'Pos', department: 'Dept', organization: organization)
    user.save
    assert_equal user.positions.count, 1
    assert_equal user.organizations.first.id, organization.id

    user.position_ids = old_positions
    user.save

  end

  test 'paranoid' do

    assert User.respond_to? :only_deleted

  end

  test 'validations' do

    assert_raises(ActiveRecord::RecordInvalid){ User.new.save! }
    assert_raises(ActiveRecord::RecordInvalid){ User.new(email: nil, name_last: 'Test').save! }
    assert_raises(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: nil).save! }
    #assert_raises(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: 'test', password: "88888888").save! }
    #assert_raises(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: 'test', password: "777aaa7").save! }
    #assert_nothing_raised(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: 'Test', password: "1111111a").save! }

  end

  test 'defaults' do

    user = User.new email: 'test@localhost', name_last: 'Test'
    assert_not user.super_admin

  end

end
