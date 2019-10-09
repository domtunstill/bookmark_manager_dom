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
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
        ) 
    end
  end
  
  def self.create(url:, title:)
    db = DatabaseConn.new(DATABASE)
    columns = 'url, title'
    values = "'#{url}', '#{title}'"
    response = db.save_values(TABLE, columns, values)
    Bookmark.new(id: response[0]['id'], url: response[0]['url'], title: response[0]['title'])
  end
  
  def self.delete(id:)
    value = id
    db = DatabaseConn.new(DATABASE)
    db.delete(TABLE, PK_COL, value)
  end

  # Instance Methods
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def db_conn
    DatabaseConn.new(DATABASE)
  end
end
