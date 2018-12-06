Rails.application.routes.draw do

  get '/' => 'post#index'

  get '/thread/new' => 'post#new'

  post '/thread' => 'post#create'

  get '/thread/:slug' => 'post#show'

  post '/thread/:slug/upvote' => 'post_upvote#create'

  post '/thread/:slug/downvote' => 'post_downvote#create'

  post '/thread/:slug/reply' => 'reply#create'

  post '/thread/:slug/reply/:id/upvote' => 'reply_upvote#create'

end
