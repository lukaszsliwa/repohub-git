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
      resources :trees, only: [] do
        resources :contents, controller: 'repositories/contents', constraints: {tree_id: /.+/, id: /.+/}
        resources :blobs, controller: 'repositories/blobs', constraints: {blob_id: /.+/, id: /.+/}
        resources :raws, controller: 'repositories/raws', constraints: {blob_id: /.+/, id: /.+/}
      end
    end

    root 'repositories#index'
  end
end
