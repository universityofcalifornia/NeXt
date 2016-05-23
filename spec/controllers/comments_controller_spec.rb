require 'rails_helper'
require 'pry'

RSpec.describe CommentsController, type: :controller do

  let(:valid_comment_attribute) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "" }
   }


  describe 'GET #new' do
    it 'assigns a new comment to a comment' do
      get :new
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'POST #create' do
    it 'Creates a new comment' do
      # @idea = FactoryGirl.create(:idea)
      # @comment = FactoryGirl.create(:comment)
      #   expect {
      #     post :create, { comment: {title: test1, body: test2, user_id: User.first.id, idea_id: Idea.first.id, parent_id: @comment.id}, format: :json  }
      #   }.to change(Comment, :count).by(1)

      # binding.pry

      # expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

end
