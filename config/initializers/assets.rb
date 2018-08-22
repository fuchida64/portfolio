# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( task_group.js )
Rails.application.config.assets.precompile += %w( diary.js )
Rails.application.config.assets.precompile += %w( user.js )
Rails.application.config.assets.precompile += %w( slick.min.js )
Rails.application.config.assets.precompile += %w( lity.js )

# home
Rails.application.config.assets.precompile += %w( homes.css )
# task
Rails.application.config.assets.precompile += %w( task_groups/index.scss )
Rails.application.config.assets.precompile += %w( task_groups/show.scss )
# diary
Rails.application.config.assets.precompile += %w( diaries/new.scss )
Rails.application.config.assets.precompile += %w( diaries/show.scss )
Rails.application.config.assets.precompile += %w( slick.css )
Rails.application.config.assets.precompile += %w( slick-theme.css )
Rails.application.config.assets.precompile += %w( lity.css )

