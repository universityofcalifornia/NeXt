FactoryGirl.define do
	
  factory :comment do
    user
    idea
    body "My first comment"
  end

end
