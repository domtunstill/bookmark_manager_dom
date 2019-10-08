require_relative 'database'

class Bookmark
  DATABASE = 'bookmark_manager'
  TABLE = 'bookmarks'
  PK_COL = 'id'

  # class methods
  def self.all
    db = DatabaseConn.new(DATABASE)
    data = db.all_records(TABLE)
    data.map do |bookmark| 
      Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) 
    end
  end
  
  def self.add(url, title)
    db = DatabaseConn.new(DATABASE)
    columns = 'url, title'
    values = "'#{url}', '#{title}'"
    db.save_values(TABLE, columns, values )
  end
  
  def self.delete(id)
    db = DatabaseConn.new(DATABASE)
    db.delete(TABLE, PK_COL, id)
  end

  # Instance Methods
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def db_conn
    DatabaseConn.new(DATABASE)
  end
    
end
