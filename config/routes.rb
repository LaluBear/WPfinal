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
  get '/logout' ,to: 'user#logout'
  get '/new_user', to: 'user#new_user'
  get '/gacha' ,to: 'user#gacha'
  get '/like/:id' ,to: 'user#like' 
  get '/unlike/:id' ,to: 'user#unlike' 
  get '/error' ,to: 'user#error'
  get '/market' ,to: 'user#market'
  
  
  get '/inventory' ,to: 'inventories#inventory'
  get '/banner/:name', to: 'banners#banner_gacha'
  
  
  get '/redeem', to: 'codes#redeem'
  
  post '/cancel/:name', to: 'user#cancel'
  
  post '/banner/:name/pull_one', to: 'banners#pull_one'
  post '/banner/:name/pull_ten', to: 'banners#pull_ten'
  post '/how_to_obtain/:name', to: 'banners#how_to_obtain'
  
  
  post '/redeem/code', to: 'codes#redeem_code'
  
  patch '/sell/:name', to: 'user#sell'
  patch '/buy/:name', to: 'user#buy'
  
  post '/login_attempt', to: 'user#login_attempt'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
