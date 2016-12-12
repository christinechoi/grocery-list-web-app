class ItemsController < ApplicationController

  # Loads the create_item page, which contains a form to create a new item
  get '/items/new' do
    if logged_in? # The user can only create an item if they're logged in
      erb :'items/create_item'
    else
      redirect to '/login' # Otherwise, they are directed to the login page
    end
  end

  # Gets the input from the create item form and creates the item
  post '/items' do
    if params[:name] == "" # The user cannot create a blank item
      redirect to '/items/new'
    else
      current_user.items.create(name: params[:name], quantity: params[:quantity])
      redirect to "/users/#{@current_user.slug}"
    end
  end
end