require 'bookmark'

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

  describe '.add' do
    # add
  end

  describe 'delete' do
    # delete
  end
end