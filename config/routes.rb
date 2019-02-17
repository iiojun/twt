Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trends, only:[ :show ] do
    collection do
      get :search
    end
  end
  root 'trends#index'
  get ':date' => 'trends#index', constraints: { date: /\d{4}-\d{2}-\d{2}/ }
  get '/search' => 'trends#search'

  namespace :api, { format: 'json' } do
    resources :trends, only:[ :show ]
    get ':date' => 'trends#index', constraints: { date: /\d{4}-\d{2}-\d{2}/ }
  end
end
