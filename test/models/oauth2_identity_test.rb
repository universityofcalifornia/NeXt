require 'test_helper'

class Oauth2IdentityTest < ActiveSupport::TestCase

  test "user relation" do

    shib = Oauth2Identity.find(1)

    assert_equal shib.provider, 'shibboleth'
    assert_equal shib.provider_user_id, 'ebollens@ucla.edu'
    assert_equal shib.user_id, 1
    assert_equal User.find(1).email, 'ebollens@oit.ucla.edu'

    assert_not_nil shib.user
    assert_equal shib.user.email, 'ebollens@oit.ucla.edu'

  end

  test 'paranoid' do

    assert Oauth2Identity.respond_to? :only_deleted

  end

end
