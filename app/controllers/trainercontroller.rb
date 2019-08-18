class TrainerController < ApplicationController

  get '/trainers' do
    authenticate
    erb :'trainers/index'
  end
  
  get '/trainers/:id' do
    authenticate
    @trainer = Trainer.find_by_id(params[:id])
    erb :'/trainers/show'
  end

end