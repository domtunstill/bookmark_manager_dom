require 'pg'

class Bookmark

  def self.all
    connection = PG.connect(dbname: 'bookmark_manager')
    data = connection.exec('SELECT * FROM bookmarks;') 
    data.map { |bookmark| bookmark['url'] }
  end  
end