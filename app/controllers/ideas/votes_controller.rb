module Ideas
  class VotesController < ApplicationController

    before_action do
      @idea = Idea.includes(:idea_status).find(params[:idea_id])
    end

    def create

      path = params[:return_to] || idea_path(@idea)

      unless current_user
        raise Application::Error.new "You must be logged in to vote for an idea.",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
      end

      vote = @idea.voted_by current_user

      vote.participate = params[:participate]
      vote.save

      current_user.alter_points :ideas, 1

      redirect_to path,
                  flash: {
                    page_alert: "Your support of #{@idea.name} is appreciated!",
                    page_alert_type: 'success'
                  }

    end

    def update

      path = params[:return_to] || idea_path(@idea)
      vote = @idea.voted_by current_user

      if vote.participate && params[:participate]=="false"
        page_alert_msg = "You have withrawn your participation from #{@idea.name}."
      elsif ! vote.participate && params[:participate]=="true"
        page_alert_msg = "Thank you for participating in #{@idea.name}!"
      end

      vote.participate = params[:participate]
      vote.save

      redirect_to path,
                flash: {
                  page_alert: page_alert_msg,
                  page_alert_type: 'success'
                }

    end

    def destroy
  
      path = params[:return_to] || idea_path(@idea)
      vote = @idea.voted_by current_user
      vote.destroy
      current_user.alter_points :ideas, -1
      redirect_to path,
                flash: {
                  page_alert: "Your support of #{@idea.name} has been withdrawn.",
                  page_alert_type: 'success'
                }

    end

  end
end