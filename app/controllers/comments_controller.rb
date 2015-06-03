class CommentsController < ApplicationController

  def new
  	
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    @idea = @comment.root.idea

    render :layout => false

  end

  def create

  	path = params[:return_to]

    unless context.user

      logger.info ('in CommentsController::create. user was not logged in')

      raise Application::Error.new "You must be logged in to comment",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
    end

    context.user.comments.create(params[:comment].permit(:parent_id, :idea_id, :body, :commit))

    redirect_to path,
                flash: {
                  page_alert: "Thanks for commenting!",
                  page_alert_type: 'success'
                }
  end

end
