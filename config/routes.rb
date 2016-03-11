Rails.application.routes.draw do
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  mount Payola::Engine => '/payola', as: :payola
  root to: 'visitors#index'
  get 'products/:id', to: 'products#show', :as => :products
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'change_plan', :to => 'registrations#change_plan'
    put 'change_card', :to => 'registrations#change_card'
    
    scope :users do
      get 'dashboard',    :to => 'users#dashboard'
      get 'subscription', :to => 'users#subscription'
      get 'promo',    :to => 'users#promo'
      get 'delivery', :to => 'users#delivery'
      get 'settings', :to => 'users#settings'
      put 'update/email', :to => 'users#update_email'
      put 'update/name', :to => 'users#update_name'
    end
  end
  resources :users

  resources 'subscriptions', :only => [] do
    put 'change_card', :to => 'subscriptions#update_card'
  end
end
