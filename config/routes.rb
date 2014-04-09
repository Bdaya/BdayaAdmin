BdayaAdmin::Application.routes.draw do
  
  resources :ideas do
    collection do
    get "gowanyat"
  end
  end


  get "committee/new"
  #get "ideas/up_vote" => "ideas#up_vote"

  resources :meetings do
    get :invite_users
    member do
      post :send_message
      post :set_attendance
    end
  end
  resources :requests
  resources :events do
    member do
      post :add_image
      get :profile_picture
      get :cover_picture
      get :requests
      post :new_materials
      post :new_permissions
    end
  end
  resources :committees do
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
