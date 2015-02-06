logger.progname = 'Seed - Project Statuses'

logger.info 'Truncate'
ProjectStatus.truncate

[
    { key: 'forming', name: 'Forming', icon: '' },
    { key: 'active', name: 'Active', icon: '' },
    { key: 'abandoned', name: 'Abandoned', icon: '' }
].each do |status|
  logger.info "Create - #{status[:key]} => #{status[:name]}"
  ProjectStatus.create status
end

