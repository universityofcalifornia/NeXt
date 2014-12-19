module Ideas
  class VotesController < ApplicationController

    before_action do
      @idea = Idea.includes(:idea_status).find(params[:idea_id])
    end

    def create

      path = params[:return_to] ? params[:return_to] : idea_path(@idea)

      unless context.user
        raise Application::Error.new "You must be logged in to vote for an idea",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
      end

      unless @idea.has_been_voted_for_by? context.user
        vote = IdeaVote.new idea: @idea, user: context.user
      else
        vote = IdeaVote.where(idea: @idea, user: context.user).first
      end

      vote.participate = params[:participate]

      vote.save

      redirect_to path,
                  flash: {
                    page_alert: "Your support of <strong>#{@idea.name}</strong> is appreciated!",
                    page_alert_type: 'success'
                  }

    end

  end
end