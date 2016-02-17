require 'rails_helper'

RSpec.describe EventsController, type: :controller do

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