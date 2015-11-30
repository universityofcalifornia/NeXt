require 'test_helper'

class EventTest < ActiveSupport::TestCase

    test 'validations' do
      assert_raises(ActiveRecord::RecordInvalid){ Event.new.save! }
      assert_raises(ActiveRecord::RecordInvalid){ Event.new(name: nil, start_datetime: DateTime.now, stop_datetime: 10.days.from_now).save! }
      assert_raises(ActiveRecord::RecordInvalid){ Event.new(name: "test", start_datetime: 10.days.from_now, stop_datetime: DateTime.now ).save! }
      assert_raises(ActiveRecord::RecordInvalid){ Event.new(name: "test", start_datetime: nil, stop_datetime: 10.days.from_now ).save! }
      assert_raises(ActiveRecord::RecordInvalid){ Event.new(name: "test", start_datetime: 10.days.from_now, stop_datetime: nil ).save! }
      assert_nothing_raised(ActiveRecord::RecordInvalid){ Event.new(name: "test", start_datetime: DateTime.now, stop_datetime: 10.days.from_now ).save! }

    end

end