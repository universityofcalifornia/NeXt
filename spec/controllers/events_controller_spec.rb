require 'rails_helper'
require 'pry'


RSpec.describe EventsController, type: :controller do

  let(:valid_event_attribute) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "" }
   }

  let(:valid_event_attribute_2) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "a@a.a" }
   }

  let(:valid_event_attribute_3) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "b@b.b" }
   }

  let(:invalid_event_attribute) {
     { start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "sad" }
   }

  describe "GET #index" do
    it "assigns all events as @events" do
      event = Event.create(start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one')
      get :index
      expect(assigns(:events)).to eq([event])
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with valid params" do
      it "creates a new event" do
        expect {
          post :create, { event: valid_event_attribute, format: :json  }
        }.to change(Event, :count).by(1)
      end
    end
  end

  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { FactoryGirl.create(:user) } }
    context "with invalid params" do
      it "doesn't create an event" do
        expect {
          post :create, { event: invalid_event_attribute  }
        }.to_not change(Event, :count)
      end
    end
  end

  describe "PUT #update" do
    before { allow(controller).to receive(:current_user) { User.first} }

    context "with valid params" do
  
      let(:attribute) do 
        { :name => 'new title' }
      end

      it "located the requested @event" do
        @event = create :event
        put :update, :id => @event.id, event: valid_event_attribute
        # assigns(:event).should eq(@event)   
        expect(assigns(:event)).to eq(@event)
      end

      it "updates an event" do
        @event = create :event
        # @event.update(valid_event_attribute)
        put :update, :id => @event.id, event: valid_event_attribute
        @event.reload
        expect(@event.name).to eq("event test")
      end

      it "updates an event by destroying an email" do
        @event = create(:event, start_datetime: Time.now, stop_datetime: 1.day.from_now(Time.now), name: 'event test', short_description: 'event test one', invite_list: "a@a.a" )
        # @event.update(valid_event_attribute)
        put :update, :id => @event.id, event: valid_event_attribute_3
        @event.reload
        expect(@event.name).to eq("event test")
      end

      it "does not update an event" do
        @event = create :event
        # @event.update(valid_event_attribute)
        put :update, :id => @event.id, event: invalid_event_attribute

        @event.reload
        expect(@event.name).to eq("My first event")
        expect(@event).to render_template(:edit)
      end

    end
  end









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