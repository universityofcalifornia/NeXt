require 'pathname'
require 'logger'

path = Pathname.new(__FILE__).parent + 'seeds'
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

[
  'idea_statuses',
  'organizations',
  'positions',
  'users',
  'ideas'
].each { |seed| instance_eval File.read "#{path}/#{seed}.rb" }


