class TrainerController < ApplicationController

  get '/login' do
    if !logged_in?
      @failed = false
      erb :'trainers/login'
    else
      @trainer = Trainer.find_by_id(session[:user_id])
      redirect "/trainer/#{@trainer.id}"
    end
  end

  post '/login' do
    @trainer = Trainer.find_by_trainer_name(params[:trainer_name])
    if !!@trainer && @trainer.authenticate(params[:password])
      session[:user_id] = @trainer.id
      redirect "/trainer/#{@trainer.id}"
    else
      @failed = true
      erb :'trainers/login'
    end
  end

  get '/signup' do
    if logged_in?
      @trainer = Trainer.find_by_id(session[:user_id])
      redirect "/trainer/#{@trainer.id}"
    else
      erb :'trainers/signup'
    end
  end


  post '/signup' do
    @trainer = Trainer.create(trainer_name: params[:trainer_name], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email])
    if @trainer.valid?
      @failed = false
      session[:user_id] = @trainer.id
      redirect "/trainer/#{@trainer.id}"
    else
      @failed = true
      erb :'trainers/signup'
    end
  end

  delete '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/trainer/:id' do
    @trainer = Trainer.find_by_id(params[:id])
    puts @trainer
    authenticate
    erb :'trainers/trainer'
  end

end