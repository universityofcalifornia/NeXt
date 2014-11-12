class AuthController < ApplicationController

  def destroy
    context.user = nil
    redirect_to root_url
  end

end
