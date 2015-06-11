FactoryGirl.define do
  factory :event do
  	user
    name "My first event"
    description "Come to my first event"
    map_url "http://my.map_url.org"
    event_url "http://my.event_url.org"
    location "new location"

    trait :with_invites do
      before(:save) do |event|
        event.invites << create(:invite)
      end
    end
  end
end
