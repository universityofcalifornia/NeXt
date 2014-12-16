require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase

  test 'paranoid' do

    assert Organization.respond_to? :only_deleted

  end

  test 'relation existence' do

    organization = Organization.new
    assert organization.respond_to? :users
    assert organization.respond_to? :users=
    assert organization.respond_to? :positions
    assert organization.respond_to? :positions=

  end

end
