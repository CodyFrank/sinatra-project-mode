class SessionsController < ApplicationController

    get '/login' do
        if !logged_in?
          @failed = false
          erb :'sessions/login'
        else
          redirect "/trainers"
        end
      end
    
      post '/login' do
        clean_params = clean(params)
        @trainer = Trainer.find_by_trainer_name(clean_params[:trainer_name])
        if !!@trainer && @trainer.authenticate(clean_params[:password])
          session[:user_id] = @trainer.id
          redirect "/trainers"
        else
          @failed = true
          erb :'sessions/login'
        end
      end
    
      get '/signup' do
        if logged_in?
          redirect "/trainers"
        else
          erb :'sessions/signup'
        end
      end
    
    
      post '/signup' do
        clean_params = clean(params)
        @trainer = Trainer.create(trainer_name: clean_params[:trainer_name], password: clean_params[:password], password_confirmation: clean_params[:password_confirmation], email: clean_params[:email])
        if @trainer.valid?
          @failed = false
          session[:user_id] = @trainer.id
          redirect "/trainers"
        else
          @failed = true
          erb :'sessions/signup'
        end
      end
    
      delete '/logout' do
        authenticate
          session.destroy
          redirect '/login'
      end

end