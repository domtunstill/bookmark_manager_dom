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

  delete '/api/bookmarks/delete/:id' do
    delete_id = params[:id]
    Bookmark.delete(id: delete_id)
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end