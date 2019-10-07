require 'pg'
require_relative 'connection'

class Bookmark

  def initialize(url)
    @url = url
  end

  def self.all
    connection = Connection.new
    data = connection.run_sql('SELECT * FROM bookmarks;') 
    data.map { |bookmark| bookmark['url'] }
  end
  
  def save_to_db
    sql = "INSERT INTO Bookmarks (url) VALUES ('" 
    sql += @url 
    sql += "');"
    
    connection = Connection.new
    connection.run_sql(sql)
  end
end