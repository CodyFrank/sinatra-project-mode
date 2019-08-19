class ApplicationController < Sinatra::Base


    configure do
        set :views, 'app/views'
        set :public_folder, 'public'
        enable :sessions
        set :session_secret, SESSION_SECRET
    end

    get '/' do
        erb :index
    end

    not_found do
      @messages = "this page does not exist"
      erb :'error'
    end

    helpers do

      def logged_in?
        !!session[:user_id]
      end

      def current_user
        Trainer.find_by_id(session[:user_id])
      end

      def authenticate
        if !logged_in?
          redirect '/login'
        end
      end

    end

end