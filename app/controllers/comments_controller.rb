class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    @idea = @comment.root.idea

    logger.info("parent id = #{@comment.parent_id}")

    render :layout => false

  end

  def create

    logger.info ('==>in comments create')

  	path = params[:return_to]

    unless context.user

      logger.info('==> no context.user')

      raise Application::Error.new "You must be logged in to comment",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
    end

    comment = Comment.new params[:comment].permit(:parent_id, :idea_id, :body, :commit)  
    comment.user_id = context.user.id
    comment.save

    redirect_to path,
                flash: {
                  page_alert: "Thanks for commenting!",
                  page_alert_type: 'success'
                }
  end

end
