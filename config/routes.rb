BdayaAdmin::Application.routes.draw do
  
  resources :meetings do
    get :invite_users
  end
  resources :requests
  #to_be_modified
  get  '/sent_tasks' , to: "tasks#sent_tasks"
  resources :tasks do
    post :done
    post :reopen
    post :accept
  end

  resources :notifications

  devise_for :users
  resources :users do
    resources :evaluations
      collection do
        post "save_evaluation"
      end
      member do
        get "set_evaluation"
        get "show_evaluation"
        get "assign_task"
        post "save_assign_task"
      end
  end

  #matching for oauth only
  match '/oauth2callback' => 'authentications#create'

  root to: 'users#home'
end
