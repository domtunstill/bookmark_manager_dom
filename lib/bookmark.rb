require_relative 'database'

class Bookmark
  DATABASE = 'bookmark_manager'
  TABLE = 'bookmarks'

  # class methods
  def self.all
    db = DatabaseConn.new(DATABASE)
    data = db.all_records(TABLE)
    data.map do |bookmark| 
      Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) 
    end
  end
  
  def self.save_to_db(url, title)
    db = DatabaseConn.new(DATABASE)
    columns = 'url, title'
    values = "'#{url}', '#{title}'"
    db.save_value(TABLE, columns, values )
  end
  
  # Instance Methods
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

end
