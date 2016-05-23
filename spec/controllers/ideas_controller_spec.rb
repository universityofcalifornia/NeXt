require 'rails_helper'
require 'pry'


RSpec.describe IdeasController, type: :controller do

  let!(:user) { FactoryGirl.create(:user) }


  let(:valid_idea_attribute) {
     { name: 'idea test 1' }
   }

  let(:invalid_idea_attribute) {
     { name: '' }
   }

  describe "GET #index" do
    it "assigns all ideas as @ideas" do
      idea = Idea.create(name: 'idea test')
      get :index
      expect(assigns(:ideas)).to eq([idea])
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with valid params" do
      it "creates a new idea" do
        expect {
          post :create, { idea: {name: 'idea test 2'}, format: :json  }
        }.to change(Idea, :count).by(1)
      end
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with invalid params" do
      it "doesn't create an idea" do
        expect {
          post :create, { idea: invalid_idea_attribute  }
        }.to_not change(Idea, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before { allow(controller).to receive(:current_user) { User.first } }
    context "for user with edit right" do
      it "destroys a idea" do
        post :create, { idea: valid_idea_attribute  }
        expect {
          delete :destroy, { id: Idea.first, format: :json  }
        }.to change(Idea, :count).by(-1)
      end
    end
  end

  describe "DELETE #destroy" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "for user without edit right" do
      it "destroys a idea" do
        post :create, { idea: valid_idea_attribute  }
        expect {
          delete :destroy, { id: Idea.first, format: :json  }
        }.to change(Idea, :count).by(0)
      end
    end
  end

end