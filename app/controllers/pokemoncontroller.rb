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
        redirect "/trainers/#{current_user.id}"
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

  patch '/pokemon/:id' do
    authenticate
    @pokemon = Pokemon.find_by_id(params[:id])
    if @pokemon.trainer.id == current_user.id

        if params[:name] != ""
          @pokemon.name = params[:name]
        end

        if params[:nickname] != ""
          @pokemon.nickname = params[:nickname]
        end

        if params[:element] != ""
          @pokemon.element = params[:element]
        end

        @pokemon.save
        redirect "pokemon/#{@pokemon.id}"
    else
        redirect "pokemon/#{@pokemon.id}/edit"
    end
  end

  delete "/pokemon/:id" do
    authenticate
    @pokemon = Pokemon.find_by_id(params[:id])
    if @pokemon.trainer.id == current_user.id
        @pokemon.delete
        redirect '/pokemon'
    else 
        redirect '/pokemon/:id'
    end
  end

end