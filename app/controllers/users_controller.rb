class UsersController < ApplicationController

  before_action do
    unless current_user
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:show, :edit, :update, :destroy] do
    @user = User.find(params[:id])

    unless @user.is_viewable_by? current_user
      redirect_forbidden "This user's profile is private."
    end
  end

  before_action only: [:edit, :update, :destroy] do
    unless @user.is_editable_by? current_user
      redirect_forbidden "You cannot edit this user."
    end
  end

  def index
    # Show all users (view hides sensitive information from hidden ones)
    @users = User.includes(:positions, :organizations)
                 .order(:name_last, :name_first)
                 .paginate(page: params[:page], per_page: 15)
  end

  def show
    @founded_ideas = @user.idea_roles.where(founder: true).includes(:idea).take(5).map(){ |idea_role| idea_role.idea }
    @supported_ideas = @user.idea_votes.includes(:idea).take(5).map(){ |idea_vote| idea_vote.idea }

    # @founded_projects = @user.project_roles.where('founder = 1 or admin = 1').includes(:project).take(5).map(){ |project_role| project_role.project }
    # @involved_projects = @user.project_roles.where('founder = 0 and admin = 0').includes(:project).take(5).map(){ |project_role| project_role.project }
    @founded_projects = @user.project_roles.where('founder = 1').includes(:project).take(5).map(){ |project_role| project_role.project }
    @involved_projects = @user.project_roles.where('founder = 0').includes(:project).take(5).map(){ |project_role| project_role.project }

    @supported_projects = @user.project_votes.includes(:project).take(5).map(&:project)
    @showcased_badges = @user.user_badges.where(showcase: true).take(5).map(&:badge)
    @givable_badges = Badge.all.select { |badge| badge.is_givable_by?(current_user) && badge.is_givable_to?(@user) }
    @founded_groups = Group.where(user_id: @user.id)
    @groups = @user.groups
  end

  def edit
    @competencies = Competency.order(name: :asc).all
    @organizations = Organization.order(name: :asc).all
    @resources = Resource.all
  end

  def update
    permitted_params = [
      :name_first,
      :name_middle,
      :name_last,
      :name_suffix,
      :website,
      :phone_number,
      :fax_number,
      :mailing_address,
      :biography,
      :social_google,
      :social_github,
      :social_linkedin,
      :social_twitter,
      :hidden,
      :dont_receive_emails,
      :activity_summary
    ]


    permitted_params << :super_admin if context.is_super_admin?
    permitted_params << :email if @user.password_hash and @user.password_hash.length > 0

    data = params[:user].permit(permitted_params)


    unless params[:user][:profile_image].blank?
      img = Magick::Image.from_blob(params[:user][:profile_image].read).first
      target = Magick::Image.new(80, 80) do
        self.background_color = 'white'
      end
      img.resize_to_fill!(80, 80)
      @image = target.composite(img, Magick::CenterGravity, Magick::CopyCompositeOp)
      file = @image.to_blob { |attrs| attrs.format = 'PNG' }
      image_data = Base64.encode64(file).gsub(/\n/, "")
      if image_data.bytesize > 500000
        flash[:page_alert_type] = 'danger'
        flash[:page_alert] = "Please upload a smaller image (< 3mb)."
        redirect_to :back
        return
      end
      current_user.profile_image = image_data
      current_user.save
    end

    if params[:user][:email] != @user.email
      if User.where(email: params[:user][:email]).count > 0
        flash[:page_alert_type] = 'danger'
        flash[:page_alert] = 'The email you are trying to change to already exists'
        redirect_to :back
        return
      end
    end

    if @user.password_hash and @user.password_hash.length > 0
      if params[:user][:password].length > 0
        if params[:user][:password] == params[:user][:password_confirmation]
          data[:password_hash] = BCrypt::Password.create(params[:user][:password])
        end
      end
    end

    @user.update data
    @user.competency_ids = params[:user][:competencies].split(',')
    @user.resource_ids = params[:user][:resources]
    @user.refresh_index!

    if params[:primary_position_organization_id]
      if params[:primary_position_organization_id] != '0'
        position = @user.primary_position ? @user.primary_position : Position.new(user_id: @user.id)
        position.organization_id = params[:primary_position_organization_id]
        position.title = params[:primary_position_title]
        position.department = params[:primary_position_department]
        position.description = params[:primary_position_description]
        position.save
      elsif @user.primary_position
        @user.primary_position.delete
      end
    end


    redirect_to user_url(@user)

  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

end
