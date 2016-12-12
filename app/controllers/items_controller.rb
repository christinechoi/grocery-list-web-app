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
    if params[:name] == "" || params[:quantity] == "" # The user cannot create a blank item
      redirect to '/items/new'
    else
      current_user.items.create(name: params[:name], quantity: params[:quantity])
      binding.pry
      redirect to "/users/#{current_user.slug}"
    end
  end

  # Loads the edit_item page, which contains a form for the user to edit an item
  get '/items/:id/edit' do
    if logged_in? # The user can only edit an item if they're logged in
      @item = Item.find_by_id(params[:id])
      erb :'/items/edit_item'
    else
      redirect to '/login' # If they aren't logged in, they're directed to the login page.
    end
  end

  # Gets the input from the form to edit an item
  patch '/items/:id' do
    @item = Item.find_by_id(params[:id])

    if params[:name] == "" || params[:quantity] == ""# The user cannot create a blank item
      redirect to "/items/#{@item.id}/edit"
    else
      @item.name = params[:name] # Updates the item with the new name
      @item.quantity = params[:quantity] # Updates the item with the new quantity
      @item.save

      redirect to "/users/#{current_user.id}"
    end
  end
end