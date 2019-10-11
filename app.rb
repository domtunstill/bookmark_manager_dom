require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/bookmarks/new' do
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(url: params[:url], title: params[:title])
    else
      flash[:notice] = "You must submit a valid URL."
    end

    redirect '/'
  end

  delete '/bookmarks/:id' do
    delete_id = params[:id]
    Bookmark.delete(id: delete_id)
    redirect '/'
  end

  get '/bookmarks/:id/edit' do
    @edit_id = params[:id]
    @bookmarks = Bookmark.all
    erb :index
  end

  patch '/bookmarks/:id' do
    edit_id = params[:id]
    new_title = params[:title]
    new_url = params[:url]
    Bookmark.edit(id: edit_id, title: new_title, url: new_url)
    redirect '/'
  end

  post '/bookmarks/:id/comments' do
    bookmark = Bookmark.get_bookmark(id: params['id'])
    bookmark.add_comment(params['comment'])
    redirect '/'
  end

  get '/bookmarks/:id/comments/new' do
    @comment_on_id = params[:id]
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/:id/tags/new' do
    @tag_on_id = params[:id]
    @bookmarks = Bookmark.all
    erb :index
  end

  run! if app_file == $PROGRAM_NAME
end
