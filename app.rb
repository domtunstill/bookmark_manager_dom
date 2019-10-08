require 'sinatra/base'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/add' do
    @url = params['url']
    @title = params['title']
    Bookmark.add(@url, @title)
    redirect '/'
  end

  post '/delete' do
    @id = params['delete_id']
    Bookmark.delete(@id)
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end