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
    pokemon = Pokemon.create(name: params[:name], nickname: params[:nickname], element: params[:element])
    if pokemon.valid?
        current_user.pokemon << pokemon
        redirect "/trainer"
    else
        redirect '/pokemon/new'
    end
  end

  get '/pokemon/:id' do
    authenticate
    @pokemon = Pokemon.find_by_id(params[:id])
    erb :'pokemon/show'
  end

  get '/pokemon/:id/edit' do
    authenticate
    @pokemon = Pokemon.find_by_id(params[:id])
    if @pokemon.trainer.id == current_user.id
        erb :'pokemon/edit'
    else
        redirect '/pokemon'
    end
  end

  patch '/articles/:id' do
  end

  put '/articles/:id' do
  end

  delete '/articles/:id' do
  end

end