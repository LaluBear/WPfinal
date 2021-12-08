Rails.application.routes.draw do
  resources :banner_items
  resources :likes
  resources :inventories
  resources :transanctions
  resources :codes
  resources :items
  resources :banners
  resources :users
  
  get '/main' ,to: 'user#login'
  get '/out' ,to: 'user#pre_login'
  get '/new_user', to: 'user#new_user'
  get '/gacha' ,to: 'user#gacha'
  get '/error' ,to: 'user#error'
  
  get '/banner/:name', to: 'banners#banner_gacha'
  get '/banner/:name/pull_one', to: 'banners#pull_one'
  get '/banner/:name/pull_ten', to: 'banners#pull_ten'
  
  post '/login_attempt', to: 'user#login_attempt'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
