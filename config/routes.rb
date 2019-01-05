Rails.application.routes.draw do
  root 'post#index'
  get '/thread' => 'post#index', as: 'post_index'
  get '/thread/new' => 'post#new', as: 'post_new'
  post '/thread' => 'post#create', as: 'post_create'
  get '/thread/:slug' => 'post#show', as: 'post_show'

  post '/thread/:slug/upvote' => 'post_upvote#create', as: 'post_upvote_create'
  post '/thread/:slug/downvote' => 'post_downvote#create', as: 'post_downvote_create'

  post '/thread/:slug/reply' => 'reply#create', as: 'reply_create'
  post '/thread/:slug/reply/:id/upvote' => 'reply_upvote#create', as: 'reply_upvote_create'
  post '/thread/:slug/reply/:id/downvote' => 'reply_downvote#create', as: 'reply_downvote_create'

  get '/thread/:slug/reply-suggestion' => 'reply_suggestion#index', as: 'reply_suggestion_index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  namespace :admin do
    get '/dashboard' => 'dashboard#index'
    get '/thread' => 'post#index'
    delete '/thread/:id' => 'post#destroy'
    get '/reply' => 'reply#index'
    delete '/reply/:id' => 'reply#destroy'
  end
end
