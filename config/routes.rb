Rails.application.routes.draw do

  get '/' => 'post#index'

  get '/thread/new' => 'post#new'

  post '/thread' => 'post#create'

  get '/thread/:slug' => 'post#show'

  post '/thread/:slug/reply' => 'reply#create'

end
