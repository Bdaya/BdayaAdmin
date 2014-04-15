BdayaAdmin::Application.routes.draw do


  devise_for :admins

  resources :meetings do
    get :invite_users
    member do
      post :set_attendance
      post :send_message
    end
  end
  
  resources :feedbacks
  get '/gowanyat' , to: "ideas#gowanyat"
  get 'ideas/top' , to: "ideas#top"
  get 'gowanyat/top' , to: "ideas#top_gowanyat"
  resources :ideas do
    member do
      post :upvote
      post :send_message
    end
  end
  resources :requests
  resources :events do
    member do
      post :add_image
      post :rate_image
      get :profile_picture
      get :cover_picture
      get :requests
      post :new_materials
      post :new_permissions
    end
  end
  #to_be_modified
  get  '/sent_tasks' , to: "tasks#sent_tasks"
  resources :tasks do
    post :done
    post :reopen
    post :accept
    member do
      post :send_message
    end
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

  namespace :admin, path: 'bd_admin' do

    root to: 'committees#index'

    resources :committees do
      member do
        post :batch_invite
      end

    end
    resources :users
    
    
  end

  #matching for oauth only
  match '/oauth2callback' => 'authentications#create'

  root to: 'users#home'
end
