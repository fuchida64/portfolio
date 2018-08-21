Rails.application.routes.draw do
  devise_for :admins, controllers: {
	  sessions:      'admins/sessions',
	  passwords:     'admins/passwords',
	  registrations: 'admins/registrations'
	}
	devise_for :users, controllers: {
	  sessions:      'users/sessions',
	  passwords:     'users/passwords',
	  registrations: 'users/registrations'
	}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #common
  resources :homes, only: [:index]

  #user
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  get 'users/:id/password/edit' => 'users#password_edit', as: 'edit_password'
  patch 'users/:id/password' => 'users#password_update'

  #admin
  resources :admins
  get 'admin/users' => 'admins#user_index', as:'admin_users'

  #task_group
  resources :task_groups

  #task
  resources :tasks do
    resource :task_details, only: [:show]
  end
  get 'tasks/:id/clear' => 'tasks#check'
  patch 'tasks/position' => 'tasks#position_update', as: 'update_position'
  patch 'tasks/:task_id/task_details' => 'task_details#update', as: 'update_limit'

  #diary
  get 'diaries/search' => 'diaries#search', as:'search_diaries'
  resources :diaries do
    resource :diary_comments
    resource :favorites
  end

  #memory_group
  resources :memory_groups do
    resource :memories, only: [:create, :show]
    resource :memory_stages, only: [:create]
  end

  #memory
  resources :memories
  get 'memories/:id/correct' => 'memories#correct', as: 'correct'
  get 'memories/:id/wrong' => 'memories#wrong', as: 'wrong'

  #default_stage
  resources :default_stages

end
