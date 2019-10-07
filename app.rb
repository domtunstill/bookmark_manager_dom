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

  run! if app_file == $0
end