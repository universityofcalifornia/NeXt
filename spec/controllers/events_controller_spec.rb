require 'rails_helper'
require 'pry'

RSpec.describe EventsController, type: :controller do

  let(:first_event_attribute) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one' }
   }

  describe "GET #index" do
    it "assigns all events as @events" do
      event = Event.create(start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one')
      get :index
      expect(assigns(:events)).to eq([event])
    end
  end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new event" do
  #       binding.pry
  #       FactoryGirl.create(:user)
  #       expect {
  #         post :create, { event: first_event_attribute, format: :json  }
  #       }.to change(Event, :count).by(1)
  #     end
  #   end
  # end


  it "Should return false for bad email input" do
    @controller = EventsController.new
    # @controller.instance_eval{ valid_email? 'test1@gmail.com, test2@gmail.com' }.expect == true
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.comtest2@gmail.com' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com;test2@gmail.com' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com test2@gmail.com' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com.test2@gmail.com' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'shaunucla.edu' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'shaun@uclaedu' }).to be false 
    expect(@controller.instance_eval{ valid_email? 'shaun.ucla@edu' }).to be false 

  end

  it "Should return true for good email input" do
    @controller = EventsController.new
    # @controller.instance_eval{ valid_email? 'test1@gmail.com, test2@gmail.com' }.expect == true
    expect(@controller.instance_eval{ valid_email? 'a@a.a' }).to be true
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com' }).to be true
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com, test2@gmail.com' }).to be true
    expect(@controller.instance_eval{ valid_email? 'test1@gmail.com,test2@gmail.com' }).to be true 

  end

end