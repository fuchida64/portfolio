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

  #共通ページ
  resources :homes, only: [:index]
  #ユーザー
  resources :users
  get 'users/:id/password/edit' => 'users#password_edit', as: 'edit_password'
  patch 'users/:id/password' => 'users#password_update'
  #管理者
  resources :admins
  get 'admin/users' => 'admins#user_index', as:'admin_users'
  #タスクグループ
  resources :task_groups
  #タスク
  resources :tasks
  get 'tasks/:id/clear' => 'tasks#check'

end
