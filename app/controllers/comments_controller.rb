class CommentsController < ApplicationController

  def new
  	
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    @idea = @comment.root.idea

    render :layout => false

  end

  def create

  	path = params[:return_to]
    flash_msg = {
                  :page_alert => "Thanks for commenting!",
                  :page_alert_type => 'success'
                }

    unless context.user

      logger.info ('in CommentsController::create. user was not logged in')

      raise Application::Error.new "You must be logged in to comment",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
    end

    begin
      context.user.comments.create!(params[:comment].permit(:parent_id, :idea_id, :body, :commit))
      flash[:page_alert] = "Thanks for commenting!"
      flash[:page_alert_type] = 'success'

    rescue Exception => e
      logger.info("Caught Exception. message=#{e.message}")
      flash[:page_alert] = e.message
      flash[:page_alert_type] = 'warning'
    end

    redirect_to path #,
                #flash: flash_msg

  end

end
