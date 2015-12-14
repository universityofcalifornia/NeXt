FactoryGirl.define do
  factory :event do
  	user
    name "My first event"
    short_description "Cool event!"
    description "Come to my first event"
    map_url "http://my.map_url.org"
    event_url "http://my.event_url.org"
    location "new location"
    start_datetime Date.today
    stop_datetime Date.today + 2.days

    trait :with_invites do
      before(:save) do |event|
        event.invites << create(:invite)
      end
    end
  end
end
