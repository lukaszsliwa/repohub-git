Rails.application.routes.draw do

  resources :repositories do
    resources :commits, controller: 'repositories/commits'
    resources :branches, controller: 'repositories/branches', constraints: {id: /.+/} do
      resources :commits, controller: 'repositories/branches/commits', constraints: {branch_id: /.+/, id: /.+/}
    end
    resources :tags, controller: 'repositories/tags', constraints: {id: /.+/} do
      resources :commits, controller: 'repositories/tags/commits', constraints: {tag_id: /.+/, id: /.+/}
    end
    resources :trees
    resources :blobs
  end

  root 'repositories#index'
end
