require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'oauth2_identity relation' do

    user = User.find(1)

    assert_equal Oauth2Identity.find(1).user_id, 1
    assert_equal Oauth2Identity.find(2).user_id, 1

    assert_not_nil user.oauth2_identities
    assert user.oauth2_identities.ids.include? 1
    assert user.oauth2_identities.ids.include? 2

  end

  test 'paranoid' do

    assert User.respond_to? :only_deleted

  end

  test 'validations' do

    assert_raises(ActiveRecord::RecordInvalid){ User.new.save! }
    assert_raises(ActiveRecord::RecordInvalid){ User.new(email: nil, name_last: 'Test').save! }
    assert_raises(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: nil).save! }

    assert_nothing_raised(ActiveRecord::RecordInvalid){ User.new(email: 'test@localhost', name_last: 'Test').save! }

  end

  test 'defaults' do

    user = User.new email: 'test@localhost', name_last: 'Test'
    assert_not user.super_admin

  end

end
