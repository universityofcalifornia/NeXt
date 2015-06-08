logger.progname = 'Seed - Project Statuses'

logger.info 'Truncate'
ProjectStatus.truncate

[
  { key: 'proposal',    name: 'Proposal',    icon: '' },
  { key: 'analysis',    name: 'Analysis',    icon: '' },
  { key: 'prototype',   name: 'Prototype',   icon: '' },
  { key: 'development', name: 'Development', icon: '' },
  { key: 'rollout',     name: 'Rollout',     icon: '' },
  { key: 'production',  name: 'Production',  icon: '' }
].each do |status|
  logger.info "Create - #{status[:key]} => #{status[:name]}"
  ProjectStatus.create status
end
