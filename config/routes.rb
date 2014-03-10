BdayaAdmin::Application.routes.draw do
  
  resources :meetings do
    get :invite_users
    post :set_attendance
  end
  resources :requests
  resources :events do
    member do
      post :add_image
      get :profile_picture
      get :cover_picture
    end
  end
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
    collection do
      get :search
    end
    member do
      post :update_image
    end
  end

  #matching for oauth only
  match '/oauth2callback' => 'authentications#create'

  root to: 'users#home'
end
