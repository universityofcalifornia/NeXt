require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  def setup
    @instance = self.class.prepare_controller_class(self.class.controller_class).new
    @instance.request = @request
  end

  test "forgery protection with exception" do
    assert_equal ApplicationController.forgery_protection_strategy, ActionController::RequestForgeryProtection::ProtectionMethods::Exception
  end

  test "context method exists" do
    assert_kind_of Application::Context, @instance.context
  end

  test "context method user" do

    assert_nil @instance.context.user

    session[:current_user_id] = 1
    @instance.context.load_from_session!
    assert_not_nil @instance.context.user
    assert_equal @instance.context.user.id, 1
    assert User.find(1).super_admin
    assert @instance.context.is_super_admin?

    session[:current_user_id] = 0
    @instance.context.load_from_session!
    assert_nil @instance.context.user

    @instance.context.user = User.find(2)
    assert_not_nil @instance.context.user
    assert_equal @instance.context.user.id, 2
    assert_equal session[:current_user_id], 2
    assert_not User.find(2).super_admin
    assert_not @instance.context.is_super_admin?

  end

end
