Rails.application.routes.draw do
  resources :polls do
    get :public, on: :collection
    post :answer, on: :member
  end
  root to: 'polls#public'
  devise_for :users
end
