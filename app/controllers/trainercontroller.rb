class TrainerController < ApplicationController

  get '/trainers' do
    authenticate
    erb :'trainers/index'
  end
  
  get '/trainers/:id' do
    clean_params = clean(params)
    authenticate
    if @trainer = Trainer.find_by_id(clean_params[:id])
      erb :'/trainers/show'
    else
      @messages = "This trainer does not exist"
      erb :error
    end
  end

  get '/trainers/:id/edit' do
    authenticate
    clean_params = clean(params)
    if @trainer = Trainer.find_by_id(clean_params[:id])
      if @trainer == current_user
        erb :'trainers/edit'
      else
        @messages = "That is not your profile to update"
        erb :error
      end
    else
      @messages = "This trainer does not exist"
      erb :'error'
    end
  end

  patch '/trainers/:id' do
    authenticate
    clean_params = clean(params)
    @failed = false
    @trainer = Trainer.find_by_id(clean_params[:id])
    if @trainer && @trainer.id == current_user.id

      if clean_params[:trainer_name] != ""
        @trainer.trainer_name = clean_params[:trainer_name]
      end

      if clean_params[:email] != ""
        @trainer.email = clean_params[:email]
      end

      
      if @trainer.valid?
        @trainer.save
        redirect "/trainers/#{@trainer.id}"
      end
      
    else
      @messages = "You cannot update this trainer info"
      erb :error
    end
  end

end