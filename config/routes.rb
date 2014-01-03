BdayaAdmin::Application.routes.draw do
  
  resources :meetings do
    get :invite_users
  end
  resources :requests
  resources :tasks do
    post :done
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
      end
  end

  #matching for oauth only
  match '/oauth2callback' => 'authentications#create'

  root to: 'users#home'
end
