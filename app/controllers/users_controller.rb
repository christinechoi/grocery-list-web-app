class UsersController < ApplicationController
  # Loads a user's page
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  # Loads the create_user page, which contains a form to create a new user
  get '/signup' do
    # If a user is already logged in, then they cannot sign up, so they'll be redirected to their page
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :"users/create_user"
    end
  end
end