class TrainerController < ApplicationController

  get '/trainers' do
    authenticate
    erb :'trainers/index'
  end
  
  get '/trainers/:id' do
    authenticate
    if @trainer = Trainer.find_by_id(params[:id])
      erb :'/trainers/show'
    else
      @messages = "This trainer does not exist"
      erb :error
    end
  end

  get '/trainers/:id/edit' do
    authenticate
    if @trainer = Trainer.find_by_id(params[:id])
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
    @trainer = Trainer.find_by_id(params[:id])
    if @trainer.id == current_user.id

      if params[:trainer_name] != ""
        @trainer.trainer_name = params[:trainer_name]
      end

      if params[:email] != ""
        @trainer.email = params[:email]
      end
      
        @trainer.save
        redirect "/trainers/#{@trainer.id}/edit"
      

    else
      redirect "/trainers/#{@trainer.id}"
    end
  end

end