require 'rufus/scheduler'

## to start scheduler
# scheduler = Rufus::Scheduler.new

# scheduler.in '2m' do
#   Invite.email_recipients
# end

# scheduler = Rufus::Scheduler.singleton

s = Rufus::Scheduler.singleton


# Stupid recurrent task...
#
s.every '100s' do #.cron('00 12 * * 1') do
  User.send_activity_summary
end
