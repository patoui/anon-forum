Rails.application.routes.draw do

  get '/' => 'post#index'

  get '/thread/new' => 'post#new'

  post '/thread' => 'post#create'

  get '/thread/:slug' => 'post#show'

end
