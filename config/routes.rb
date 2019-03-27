Rails.application.routes.draw do
  resources :posts, only: [:create] do
    patch :rate, on: :member
    get 'rating/:size' => :index, as: :top_rated, on: :collection
  end

  get 'ips', to: 'ips#index'
end
