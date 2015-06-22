module Projects
  class DocumentsController < ApplicationController

    before_action do
      @project  = Project.find params[:project_id]
    end

    before_action except: [:show] do
      render nothing: true, status: :unauthorized unless @project.is_editable_by? current_user
    end

    before_action only: [:show, :edit, :update, :destroy] do
      @document = @project.project_documents.find params[:id]
    end

    def show
      type = MIME::Types.type_for(@document.filename_identifier).first.content_type

      send_file @document.filename.path, :type => type, :disposition => "inline"
    end

    def index
    end

    def new
      @document = ProjectDocument.new
    end

    def create
      @project.project_documents << ProjectDocument.create(
        params[:project_document].permit(:filename, :description)
      )

      redirect_to @project
    end

    def edit
    end

    def update
      @document.description = params[:project_document][:description]
      @document.save

      redirect_to @project
    end

    def destroy
      @document.destroy

      redirect_to @project
    end

  end
end
