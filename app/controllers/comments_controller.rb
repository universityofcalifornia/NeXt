class CommentsController < ApplicationController

  before_action :find_comment, only: [:edit, :update, :destroy]

  before_action only: [:edit, :update, :destroy] do
    render nothing: true, status: :unauthorized unless @comment.is_editable_by? current_user
  end

  def new
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    @comment.commentable = @comment.root.commentable
    render :layout => false
  end

  def create
    unless context.user
      raise Application::Error.new "You must be logged in to comment",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
    end
    begin
      context.user.comments.create!(params[:comment].permit(:parent_id, :commentable_id, :commentable_type, :body, :commit))
      case params[:commentable_type]
      when "Idea"
        current_user.alter_points :ideas, 2
      when "Project"
        current_user.alter_points :projects, 2
      end
      
      flash[:page_alert] = "Thanks for commenting!"
      flash[:page_alert_type] = 'success'
    rescue Exception => e
      flash[:page_alert] = e.message
      flash[:page_alert_type] = 'warning'
    end
    redirect_to params[:return_to] 
  end

  def destroy
    case
    when @comment.commentable_type == "Idea"
      current_user.alter_points :ideas, -2
    when @comment.commentable_type == "Project"
      current_user.alter_points :projects, -2
    end 
    @comment.destroy
    flash[:page_alert] = "The comment was deleted successfully."
    flash[:page_alert_type] = 'success'
    redirect_to params[:return_to] 
  end

  private
    def find_comment
      @comment = Comment.find_by(:id => params[:id])
    end

end
