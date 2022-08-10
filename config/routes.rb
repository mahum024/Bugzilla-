# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :projects do
 
    get 'add_developer_qa'
    match 'add/:id' => 'projects#add', :as => 'add_user', via: %i[get patch]
    match 'remove/:id' => 'projects#remove', :as => 'remove_user', via: %i[get patch]
  end
  resources :bugs
end
