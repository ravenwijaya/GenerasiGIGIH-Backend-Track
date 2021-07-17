require 'sinatra'

get '/messages/:name' do
  name = params['name']
  color = params['color'] ? params['color'] : 'DodgerBlue'
  erb :message, locals:{
    color: color,
    name: name
  }
end

get '/login' do
  erb :login
end

post '/login' do
  if params['username'] == 'admin' && params['password'] == 'admin' 
    redirect '/messages/raven'
  else
    redirect '/login'
  end
end
#============================================

item_arr = ['Item One', 'Item Two', 'Item Three']

get '/items' do
  new_item = params['new_item']
  erb :index, locals:{
    items: item_arr,
  }
end
get '/items/create' do
  erb :form
end

post '/items' do
  item_arr << params['item_name']
  redirect "/items"
end
