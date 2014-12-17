logger.progname = 'Seed - Idea Statuses'

logger.info 'Truncate'
IdeaStatus.truncate

[
  { key: 'concept', name: 'Conceptualization' },
  { key: 'forming', name: 'Seeking Support' },
  { key: 'started', name: 'Started Project' },
  { key: 'abandoned', name: 'Abandoned' }
].each do |status|
  logger.info "Create - #{status[:key]} => #{status[:name]}"
  IdeaStatus.create status
end

