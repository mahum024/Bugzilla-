# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'projects#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
 
  resources :projects do
    resources :bugs, shallow: true
    get 'add_developer_qa'
    match 'add/:user_id' => 'projects#add', :as => 'add_user', via: %i[get patch]
    match 'remove/:user_id' => 'projects#remove', :as => 'remove_user', via: %i[get patch]
  end
  resources :bugs, except: %i[new index create] do
    match 'mark_resolved' => 'bugs#mark_resolved', :as => 'mark_resolved', via: %i[get patch]
    match 'assign_developer' => 'bugs#assign_developer', :as => 'assign_developer', via: %i[get patch]
  end
end
