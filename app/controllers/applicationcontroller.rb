class ApplicationController < Sinatra::Base


    configure do
        set :views, 'app/views'
        set :public_folder, 'public'
        enable :sessions
    end

    get '/' do
        erb :index
    end

end