require 'rails_helper'
require 'pry'


RSpec.describe ProjectsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }


  let(:valid_project_attribute) {
     { name: 'project test 1' }
   }

  let(:invalid_project_attribute) {
     { name: 'project test bad', website_url: 'asdqew@qwe' }
   }

  describe "GET #index" do
    it "assigns all projects as @projects" do
      project = Project.create(name: 'project test')
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with valid params" do
      it "creates a new project" do
        expect {
          post :create, { project: valid_project_attribute, format: :json  }
        }.to change(Project, :count).by(1)
      end
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with invalid params" do
      it "doesn't create an project" do
        expect {
          post :create, { project: invalid_project_attribute  }
        }.to_not change(Project, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before { allow(controller).to receive(:current_user) { User.first } }
    context "for users with edit right" do
      it "destroys a project" do
        post :create, { project: valid_project_attribute  }
        expect {
          delete :destroy, { id: Project.first.id, format: :json  }
        }.to change(Project, :count).by(-1)
      end
    end
  end

  describe "DELETE #destroy" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "for users without edit right" do
      it "destroys a project" do
        post :create, { project: valid_project_attribute  }
        expect {
          delete :destroy, { id: Project.first.id, format: :json  }
        }.to change(Project, :count).by(0)
      end
    end
  end

end