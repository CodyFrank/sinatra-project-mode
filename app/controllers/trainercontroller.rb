class TrainerController < ApplicationController

  get '/login' do
    erb :'trainers/login'
  end

  post '/login' do
    trainer = Trainer.find_by_trainer_name(params[:trainer_name])
    if !!trainer && trainer.authenticate(params[:password])
      session[:user_id] = trainer.id
      redirect '/trainer'
    else
      erb :'trainers/login'
    end
  end

  get '/signup' do
    erb :'trainers/signup'
  end

  post '/signup' do
  end

  get '/trainer' do
    erb :'trainers/trainer'
  end

end