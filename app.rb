require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  
  get '/' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/api/bookmarks/new' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/'
  end

  delete '/api/bookmarks/:id' do
    delete_id = params[:id]
    Bookmark.delete(id: delete_id)
    redirect '/'
  end

  get '/api/bookmarks/:id/edit' do
    @edit_id = params[:id]
    @bookmarks = Bookmark.all
    erb :index
  end

  patch '/api/bookmarks/:id' do
    edit_id = params[:id]
    new_title = params[:title]
    new_url = params[:url]
    Bookmark.edit(id: edit_id, title: new_title, url: new_url)
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end