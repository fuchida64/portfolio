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
Rails.application.config.assets.precompile += %w( memory_group.js )
Rails.application.config.assets.precompile += %w( diary.js )
Rails.application.config.assets.precompile += %w( user.js )
Rails.application.config.assets.precompile += %w( slick.min.js )
Rails.application.config.assets.precompile += %w( lity.js )

# admins
Rails.application.config.assets.precompile += %w( admins.scss )
# homes
Rails.application.config.assets.precompile += %w( homes.css )

# users
Rails.application.config.assets.precompile += %w( users/registrations/new.scss )
Rails.application.config.assets.precompile += %w( users/sessions/new.scss )
Rails.application.config.assets.precompile += %w( users/passwords/new.scss )
Rails.application.config.assets.precompile += %w( users/passwords/edit.scss )
Rails.application.config.assets.precompile += %w( users/password_edit.scss )
Rails.application.config.assets.precompile += %w( users/confirmations/new.scss )

# tasks
Rails.application.config.assets.precompile += %w( task_groups/index.scss )
Rails.application.config.assets.precompile += %w( task_groups/show.scss )
Rails.application.config.assets.precompile += %w( task_details/show.scss )
# memories
Rails.application.config.assets.precompile += %w( memory_groups/index.scss )
Rails.application.config.assets.precompile += %w( default_stages/index.scss )
Rails.application.config.assets.precompile += %w( memory_groups/show.scss )
Rails.application.config.assets.precompile += %w( memory_stages/show.scss )
Rails.application.config.assets.precompile += %w( memories/index.scss )
Rails.application.config.assets.precompile += %w( memories/show.scss )
# diaries
Rails.application.config.assets.precompile += %w( diaries/index.scss )
Rails.application.config.assets.precompile += %w( diaries/new.scss )
Rails.application.config.assets.precompile += %w( diaries/show.scss )
Rails.application.config.assets.precompile += %w( slick.css )
Rails.application.config.assets.precompile += %w( slick-theme.css )
Rails.application.config.assets.precompile += %w( lity.css )

