require 'sinatra'
require_relative '../gigih/controllers/itemcontroller'


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