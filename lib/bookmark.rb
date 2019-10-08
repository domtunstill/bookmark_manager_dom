require_relative 'database'

class Bookmark
  DATABASE = 'bookmark_manager'
  TABLE = 'bookmarks'
  COLUMN = 'url'
  MAX_LENGTH = 60

  def initialize(url)
    @url = url
  end

  def self.all
    db = DatabaseConn.new(DATABASE)
    data = db.all_records(TABLE)
    data.map { |bookmark| bookmark['url'] }
  end

  def save_to_db
    puts 'Invalid URL' unless url_valid?
    db = DatabaseConn.new(DATABASE)
    db.save_value(TABLE, COLUMN, @url)
  end

  def url_valid?
    return false if @url.length > MAX_LENGTH
  end
end
