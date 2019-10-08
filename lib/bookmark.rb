require_relative 'database'

class Bookmark

  MAX_LENGTH = 60
  TABLE_NAME = 'bookmarks'

  def initialize(url)
    @url = url
  end

  def self.all
    db = Database_conn.new
    data = db.all_records(TABLE_NAME)
    data.map { |bookmark| bookmark['url'] }
  end
  
  def save_to_db
    puts "Invalid URL" unless url_valid?
    db = Database_conn.new
    # TABLE, COLUMN, VALUE
    db.save_value(TABLE_NAME, 'url', @url )
  end

  def url_valid?
    return false if @url.length > MAX_LENGTH
  end

end