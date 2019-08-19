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
    authenticate
    pokemon = Pokemon.create(name: params[:name], nickname: params[:nickname], element: params[:element])
    if pokemon.valid?
        current_user.pokemon << pokemon
        redirect "/trainers/#{current_user.id}"
    else
        @messages = "There was a problem catching your pokemon. Please make sure all of the boxes are filled in"
        erb :'pokemon/new'
    end
  end

  get '/pokemon/:id' do
    authenticate
    if @pokemon = Pokemon.find_by_id(params[:id])
      erb :'pokemon/show'
    else
      @messages = "oops! looks like that pokemon doesn't exist please try again."
      erb :'error'
    end
  end

  get '/pokemon/:id/edit' do
    authenticate
    if @pokemon = Pokemon.find_by_id(params[:id])
      if @pokemon.trainer.id == current_user.id
          erb :'pokemon/edit'
      else
          @messages = "That is not your Pokemon to edit"
          erb :error
      end
    else
      @messages = "oops! looks like that pokemon doesn't exist please try again."
      erb :error
    end
  end

  patch '/pokemon/:id' do
    authenticate
    if @pokemon = Pokemon.find_by_id(params[:id])
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
  
          if @pokemon.valid?
            @pokemon.save
            redirect "pokemon/#{@pokemon.id}"
          else
            @messages = "Something has gone wrong"
            erb :'pokemon/edit'
          end
      else
          @messages = "That is not your Pokemon to edit"
          erb :error
      end
    else 
      @messages = "oops! looks like that pokemon doesn't exist please try again."
      erb :error
    end
  end

  delete "/pokemon/:id" do
    authenticate
    if @pokemon = Pokemon.find_by_id(params[:id])
      if @pokemon.trainer.id == current_user.id
          @pokemon.delete
          redirect '/pokemon'
      else 
          redirect "/pokemon/#{@pokemon.id}"
      end
    else
      @messages - "oops! looks like that pokemon doesn't exist please try again."
      erb :error
    end
  end

end