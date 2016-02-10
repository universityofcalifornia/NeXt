require 'rufus/scheduler'

## to start scheduler
# scheduler = Rufus::Scheduler.new

# scheduler.in '2m' do
#   Invite.email_recipients
# end

scheduler = Rufus::Scheduler.singleton
