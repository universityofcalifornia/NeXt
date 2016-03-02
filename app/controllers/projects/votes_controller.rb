module Projects
  class VotesController < ApplicationController

    before_action do
      @project = Project.includes(:project_status).find(params[:project_id])
    end

    def create

      path = params[:return_to] || project_path(@project)      
      unless current_user
        raise Application::Error.new "You must be logged in to vote for a project",
                                     redirect_to: [
                                         auth_oauth2_launch_url(:shibboleth),
                                         flash: { return_to: path }
                                     ]
      end

      vote = @project.voted_by current_user
      vote.participate = params[:participate]
      vote.save

      current_user.alter_points :projects, 1

      if vote.participate 
        @project.project_roles.founders.each do |project_role|
          ProjectNotifier.notify_founder(User.where(id: project_role.user_id).first, current_user, @project)
        end
      end

      redirect_to path,
                  flash: {
                    page_alert: "Your support of <strong>#{@project.name}</strong> is appreciated!",
                    page_alert_type: 'success'
                  }

    end

    def update
      path = params[:return_to] || project_path(@project)
      vote = @project.voted_by current_user

      if vote.participate && params[:participate]=="false"
        page_alert_msg = "You have withrawn your participation from #{@project.name}."
      elsif ! vote.participate && params[:participate]=="true"
        page_alert_msg = "Thank you for participating in #{@project.name}!"
        @project.project_roles.founders.each do |project_role|
          ProjectNotifier.notify_founder(User.where(id: project_role.user_id).first, current_user, @project)
        end
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
      path = params[:return_to] || project_path(@project)
      vote = @project.voted_by current_user
      vote.destroy
      current_user.alter_points :projects, -1
      redirect_to path,
                flash: {
                  page_alert: "Your support of #{@project.name} has been withdrawn.",
                  page_alert_type: 'success'
                }
    end

  end
end
