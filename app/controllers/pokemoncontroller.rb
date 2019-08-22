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
    clean_params = clean(params)
    pokemon = Pokemon.create(name:clean_params[:name], nickname: clean_params[:nickname], element: clean_params[:element])
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
    clean_params = clean(params)
    if @pokemon = Pokemon.find_by_id(clean_params[:id])
      erb :'pokemon/show'
    else
      @messages = "oops! looks like that pokemon doesn't exist please try again."
      erb :'error'
    end
  end

  get '/pokemon/:id/edit' do
    authenticate
    clean_params = clean(params)
    if @pokemon = Pokemon.find_by_id(clean_params[:id])
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
    clean_params = clean(params)
    if @pokemon = Pokemon.find_by_id(clean_params[:id])
      if @pokemon.trainer.id == current_user.id
  
          if clean_params[:name] != ""
            @pokemon.name = clean_params[:name]
          end
  
          if clean_params[:nickname] != ""
            @pokemon.nickname = clean_params[:nickname]
          end
  
          if clean_params[:element] != ""
            @pokemon.element = clean_params[:element]
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
    clean_params = clean(params)
    if @pokemon = Pokemon.find_by_id(clean_params[:id])
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