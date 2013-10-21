Blog::Application.routes.draw do
  get "welcome/index"

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :posts do 
    resources :comments
  end

  root 'welcome#index'
end
