require 'sinatra'
require_relative '../gigih/controllers/itemcontroller'
require_relative '../gigih/controllers/categorycontroller'
get '/menus' do
  ItemController.listitem
end

get '/items/new' do
  erb :create
end

post '/items/create' do
  ItemController.additem(params)
  redirect '/menus'
end

get '/items/:id' do
  ItemController.show_by_id(params)
end

get '/items/:id/edit' do
  ItemController.edit_by_id(params)
end

post '/edit/:id' do
  ItemController.action_edit_by_id(params)
  redirect '/menus'
end

get '/delete/:id' do
  ItemController.delete_by_id(params)
  redirect '/menus'
end

# =============================== category ==========================
get '/category' do
  CategoryController.listcategory(params)
end

post '/category' do
  CategoryController.listcategory(params)
end

get '/category/new' do
  erb :create_category
end

post '/category/create' do
  CategoryController.addcategory(params)
  redirect '/category'
end

get '/category/:id/edit' do
  CategoryController.edit_by_id(params)
end

post '/category/:id/edit' do
  CategoryController.action_edit_by_id(params)
  redirect '/category'
end

get '/category/delete/:id' do
  CategoryController.delete_by_id(params)
  redirect '/category'
end


