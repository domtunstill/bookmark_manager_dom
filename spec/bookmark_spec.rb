require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.destroyallsoftware.com', 'DAS');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google');")
  
      bookmarks = Bookmark.all
  
      expect(bookmarks[0].title).to eq('Makers')
      expect(bookmarks[0].url).to eq('http://www.makersacademy.com')

      expect(bookmarks[1].title).to eq('DAS')
      expect(bookmarks[1].url).to eq('http://www.destroyallsoftware.com')

      expect(bookmarks[2].title).to eq('Google')
      expect(bookmarks[2].url).to eq('http://www.google.com')
      # expect(bookmarks).to include('http://www.destroyallsoftware.com')
      # expect(bookmarks).to include('http://www.google.com')
      
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Google'
      expect(bookmark.url).to eq 'http://www.google.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark_1 = connection.exec("
        INSERT INTO bookmarks (url, title) 
        VALUES ('http://www.google.com', 'Google') 
        RETURNING * ;")

      bookmark_2 = connection.exec("
        INSERT INTO bookmarks (url, title) 
        VALUES ('http://www.makers.tech', 'Makers') 
        RETURNING * ;")

      expect(Bookmark.all.length).to eq 2
      Bookmark.delete(id: bookmark_1.first['id'])
      expect(Bookmark.all.length).to eq 1

    end
  end
end