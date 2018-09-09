Rails.application.routes.draw do

  devise_for :admins, controllers: {
	  sessions:      'admins/sessions',
	  passwords:     'admins/passwords',
	  registrations: 'admins/registrations'
	}
	devise_for :users, controllers: {
	  sessions:      'users/sessions',
	  passwords:     'users/passwords',
	  registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    mailer:        'users/mailer'
	}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # admin
  resources :admins, only: [:index, :edit, :update]
  get 'admin/users' => 'admins#user_index', as:'admin_users'

  # common
  resources :homes, only: [:index]

  # user
  # show edit update
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  get 'users/:id/password/edit' => 'users#password_edit', as: 'edit_password_user'
  patch 'users/:id/password' => 'users#password_update'

  # task_group
  # index create update destroy show
  resources :task_groups
  post 'task_groups/position' => 'task_groups#position_update'
  delete 'task_groups/:id/clear' => 'task_groups#destroy_all', as: 'destroy_all'

  # task
  # update delete create
  resources :tasks do
    resource :task_details, only: [:show]
  end
  get 'tasks/:id/clear' => 'tasks#check'
  post 'tasks/position' => 'tasks#position_update', as: 'update_position'
  patch 'tasks/:task_id/task_details' => 'task_details#update', as: 'update_limit'

  # diary
  # index show new create edit update delete
  resources :diaries do
    resource :diary_comments, only: [:create]
    resource :favorites, only: [:create, :destroy]
  end
  get 'search/diaries' => 'diaries#search', as:'search_diaries'

  # memory_group
  # show update
  resources :memory_groups, except: [:new, :edit] do
    resource :memories, only: [:create, :show]
    resource :memory_stages, only: [:show]
  end
  post 'memory_groups/position' => 'memory_groups#position_update'
  get 'memory_groups/:memory_group_id/step/memories' => 'memories#step_index', as:'step_index'

  # memory
  # index create update delete
  resources :memories
  get 'memories/:id/correct' => 'memories#correct', as: 'correct'
  get 'memories/:id/wrong' => 'memories#wrong', as: 'wrong'

  # default_stage
  # index create update destroy
  resources :default_stages, except: [:new, :show, :edit]

  # memory_stage
  # update destroy create
  resources :memory_stages, only: [:create, :update, :destroy]

end
