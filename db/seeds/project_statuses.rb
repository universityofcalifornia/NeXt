logger.progname = 'Seed - Project Statuses'

[
  { key: 'forming',   name: 'Forming - recruiting resources', icon: '' },
  { key: 'active',    name: 'Active - fully resourced',       icon: '' },
  { key: 'completed', name: 'Successfully completed',         icon: '' },
  { key: 'deployed',  name: 'Deployed',                       icon: '' },
  { key: 'abandoned', name: 'Abandoned',                      icon: '' }
].each do |status|
  logger.info "Create - #{status[:key]} => #{status[:name]}"
  ProjectStatus.create status
end
