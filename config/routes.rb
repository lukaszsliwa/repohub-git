Rails.application.routes.draw do

  resources :repositories do
    resources :commits, controller: 'repositories/commits'
    resources :branches, controller: 'repositories/branches'
    resources :tags, controller: 'repositories/tags'
    resources :trees
    resources :blobs
  end

  root 'repositories#index'
end
