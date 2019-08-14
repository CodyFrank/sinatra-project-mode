class TrainerController < ApplicationController

  get '/login' do
    @failed = false
    erb :'trainers/login'
  end

  post '/login' do
    trainer = Trainer.find_by_trainer_name(params[:trainer_name])
    if !!trainer && trainer.authenticate(params[:password])
      session[:user_id] = trainer.id
      redirect '/trainer'
    else
      @failed = true
      erb :'trainers/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/trainer'
    else
      erb :'trainers/signup'
    end
  end

  post '/signup' do
    if params[:trainer_name] == "" || params[:email] == "" || params[:password] == ""
      @failed = true
      erb :'trainers/signup'
    else
      @failed = false
      @trainer = Trainer.create(trainer_name: params[:trainer_name], password: params[:password], email: params[:email])
      session[:user_id] = @trainer.id
      redirect '/trainer'
    end
  end

  get '/trainer' do
    authenticate
    erb :'trainers/trainer'
  end

end