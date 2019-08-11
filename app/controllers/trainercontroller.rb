class TrainerController < ApplicationController

  get '/login' do
    erb :'trainers/login'
  end

  get '/signup' do
    erb :'trainers/signup'
  end

end