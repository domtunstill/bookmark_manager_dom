require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/add' do
    @url = params['url']
    @title = params['title']
    @bookmark = Bookmark.save_to_db(@url, @title)
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end