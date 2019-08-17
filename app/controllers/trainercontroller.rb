class TrainerController < ApplicationController

  get '/login' do
    if !logged_in?
      @failed = false
      erb :'trainers/login'
    else
      redirect "/trainers"
    end
  end

  post '/login' do
    @trainer = Trainer.find_by_trainer_name(params[:trainer_name])
    if !!@trainer && @trainer.authenticate(params[:password])
      session[:user_id] = @trainer.id
      redirect "/trainers"
    else
      @failed = true
      erb :'trainers/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/trainers"
    else
      erb :'trainers/signup'
    end
  end


  post '/signup' do
    @trainer = Trainer.create(trainer_name: params[:trainer_name], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email])
    if @trainer.valid?
      @failed = false
      session[:user_id] = @trainer.id
      redirect "/trainers"
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

  get '/trainers' do
    authenticate
    erb :'trainers/index'
  end

end