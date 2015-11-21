class CommentsController < ApplicationController

  def new
  	
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    @comment.commentable = @comment.root.commentable

    render :layout => false

  end

  def create

  	path = params[:return_to]

    unless context.user

      #logger.info ('in CommentsController::create. user was not logged in')

      raise Application::Error.new "You must be logged in to comment",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
    end

    begin
      context.user.comments.create!(params[:comment].permit(:parent_id, :commentable_id, :commentable_type, :body, :commit))
      current_user.alter_points :ideas, 2
      flash[:page_alert] = "Thanks for commenting!"
      flash[:page_alert_type] = 'success'

    rescue Exception => e
      flash[:page_alert] = e.message
      flash[:page_alert_type] = 'warning'
    end

    redirect_to path 

  end

end
