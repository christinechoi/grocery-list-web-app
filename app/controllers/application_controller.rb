require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "grocery_secret"
  end

  get '/' do
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :index
    end
  end

  # Helper methods
  helpers do
    # Check if user is logged in
    def logged_in?
      !!session[:user_id]
    end

    # Finds current User using the current user id
    def current_user
      User.find(session[:user_id])
    end
  end

end