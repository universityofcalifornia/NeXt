require 'test_helper'
module Auth
  module Local
    class RegistrationControllerTest < ActionController::TestCase

      test "Shouldn't create user" do
        assert_no_difference('User.count') do
          post :create, user: {email: 'test2@ucla.edu', name_last: 'test', password: '88888888', password_confirmation: '88888888'}
        end
      end

      test "Shouldn't create user" do
        assert_no_difference('User.count') do
          post :create, user: {email: 'test3@ucsc.edu', name_last: 'test', password: 'aaaa8aaaaaa', password_confirmation: 'aaaa8aaaaaa'}
        end
      end


    end

  end
end