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
  resources :tasks
  get 'tasks/:id/clear' => 'tasks#check'
  post 'tasks/position' => 'tasks#position_update', as: 'update_position'

  #diary
  get 'diaries/search' => 'diaries#search', as:'search_diaries'
  resources :diaries do
    resource :diary_comments
    resource :favorites
  end

  #memory_group
  resources :memory_groups do
    resource :memories, only: [:create, :show]
  end

  #memory
  resources :memories
  get 'memories/:id/correct' => 'memories#correct', as: 'correct'
  get 'memories/:id/wrong' => 'memories#wrong', as: 'wrong'

  #memory_stage
  resources :memory_stages

end
