require 'test_helper'

class PrivacyTest < ActiveSupport::TestCase
  def setup
    @admin_user  = User.find(1)
    @normal_user = User.find(2)
  end

  test "Objects without privacy support are always viewable" do
    org = Organization.new

    assert org.is_viewable_by? nil
    assert org.is_viewable_by? @normal_user
  end

  test "Objects default to viewable by anyone" do
    idea = Idea.new

    assert idea.is_viewable_by? nil
    assert idea.is_viewable_by? @normal_user
  end

  test "Objects with basic privacy options are viewable by logged-in users" do
    idea = Idea.new
    idea.privacies << Privacy.new

    assert idea.is_viewable_by? @normal_user
    assert_not idea.is_viewable_by? nil
  end

  test "User objects default to viewable by logged-in users" do
    user = User.new

    assert user.is_viewable_by? user
    assert user.is_viewable_by? @normal_user
    assert_not user.is_viewable_by? nil
  end

  test "Hidden objects are only viewable by the owner (or admins)" do
    user = User.new
    user.hidden = true

    assert user.is_viewable_by? user
    assert user.is_viewable_by? @admin_user
    assert_not user.is_viewable_by? @normal_user
    assert_not user.is_viewable_by? nil
  end

  test "Objects private to an org are only viewable by users of that org" do
    eric = User.find(1)
    joe_bruin = User.find(2)
    ucla = Organization.find(1)

    eric.organization = ucla
    joe_bruin.organization = ucla
    idea = Idea.new
    idea.organizations << ucla

    assert idea.is_viewable_by? eric
    assert idea.is_viewable_by? joe_bruin
    assert_not idea.is_viewable_by? User.new
    assert_not idea.is_viewable_by? nil
  end
end
