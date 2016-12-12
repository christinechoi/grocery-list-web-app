class UsersController < ApplicationController
  # Loads a user's page
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end
end