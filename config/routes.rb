Rails.application.routes.draw do
  get '/' => 'post#index'
  get '/thread/new' => 'post#new'
  post '/thread' => 'post#create'
  get '/thread/:slug' => 'post#show'

  post '/thread/:slug/upvote' => 'post_upvote#create'
  post '/thread/:slug/downvote' => 'post_downvote#create'

  post '/thread/:slug/reply' => 'reply#create'
  post '/thread/:slug/reply/:id/upvote' => 'reply_upvote#create'
  post '/thread/:slug/reply/:id/downvote' => 'reply_downvote#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  namespace :admin do
    get '/dashboard' => 'dashboard#index'
    get '/thread' => 'post#index'
    delete '/thread/:id' => 'post#destroy'
  end
end
