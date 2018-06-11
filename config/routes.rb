Rails.application.routes.draw do
  constraints(format: 'json') do
    resources :repositories do
      resources :commits, controller: 'repositories/commits' do
        get :first, on: :collection
      end
      resources :branches, controller: 'repositories/branches', constraints: {id: /.+/}
      resources :tags, controller: 'repositories/tags', constraints: {id: /.+/}
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
