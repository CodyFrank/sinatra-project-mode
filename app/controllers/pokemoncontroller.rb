class PokemonController < ApplicationController

  get '/pokemon' do
    authenticate
    @pokemon = Pokemon.all
    erb :'pokemon/index'
  end

  get '/pokemon/new' do
    authenticate
    erb :'pokemon/new'
  end

  post '/pokemon' do
  end

  get '/pokemon/:id' do
  end

  get '/pokemon/:id/edit' do
  end

  patch '/articles/:id' do
  end

  put '/articles/:id' do
  end

  delete '/articles/:id' do
  end

end