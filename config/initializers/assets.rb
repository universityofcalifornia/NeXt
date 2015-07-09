# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( blocks.js blocks.css jquery_ujs.js jquery.tokeninput.js token-input.css  jquery.datetimepicker.css  jquery.datetimepicker.js new_group.js groups.js)
