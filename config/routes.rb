Rails.application.routes.draw do

  get '/' => 'post#index'

  get '/thread/new' => 'post#new'

  post '/thread' => 'post#create'

end
