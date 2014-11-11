module Application
  class Context

    attr_reader :user

    def initialize options = {}
      @controller = options.include?(:controller) ? options[:controller] : nil
      @user = options.include?(:user) ? options[:user] : nil
    end

    def load_from_session!
      current_user_id = @controller.session[:current_user_id]
      @user = current_user_id ? User.find_by_id(current_user_id) : nil
      @controller.session[:current_user_id] = nil if @user.nil? and @controller.session[:current_user_id]
    end

    def user= user
      @user = user
      @controller.session[:current_user_id] = user ? user.id : nil
    end

    def is_super_admin?
      user and user.super_admin
    end

  end
end