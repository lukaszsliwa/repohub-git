Rails.application.routes.draw do
  constraints(format: 'json') do
    resources :repositories do
      resources :commits, controller: 'repositories/commits'
      resources :branches, controller: 'repositories/branches', constraints: {id: /.+/} do
        resources :commits, controller: 'repositories/commits', constraints: {branch_id: /.+/, id: /.+/}
      end
      resources :tags, controller: 'repositories/tags', constraints: {id: /.+/} do
        resources :commits, controller: 'repositories/commits', constraints: {tag_id: /.+/, id: /.+/}
      end
      resources :contents, controller: 'repositories/contents'
      resources :trees, controller: 'repositories/trees', only: :show do
        resources :contents, controller: 'repositories/trees/contents', constraints: {id: /.+/}
        resources :blobs, controller: 'repositories/trees/blobs', constraints: {id: /.+/}
        resources :raws, controller: 'repositories/trees/raws', constraints: {id: /.+/}
      end
    end

    root 'repositories#index'
  end
end
