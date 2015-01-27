# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( public.css )
Rails.application.config.assets.precompile += %w( jquery-1.11.1.js )
Rails.application.config.assets.precompile += %w( strophe-custom-1.0.0.js )
Rails.application.config.assets.precompile += %w( json2.js )
Rails.application.config.assets.precompile += %w( easemob.im-1.0.4.js )
Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( webim.css )
Rails.application.config.assets.precompile += %w( bootstrap.css )