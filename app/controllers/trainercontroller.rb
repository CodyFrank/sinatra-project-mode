class TrainerController < ApplicationController

  get '/login' do
    erb :'trainers/login'
  end

  post '/login' do
  end

  get '/signup' do
    erb :'trainers/signup'
  end

end