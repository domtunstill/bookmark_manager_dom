require_relative 'database'

class Bookmark
  DATABASE = 'bookmark_manager'
  TABLE = 'bookmarks'
  PK_COL = 'id'

  # class methods
  def self.all
    all_data = Bookmark.sql_all_records
    all_data.map do |bookmark| 
      Bookmark.new(
        id: bookmark['id'],
        url: bookmark['url'],
        title: bookmark['title'],) 
    end
  end
  
  def self.create(url:, title:)
    db_response = Bookmark.sql_add_record(url: url, title: title)
    Bookmark.new(
      id: db_response[0]['id'], 
      url: db_response[0]['url'], 
      title: db_response[0]['title'])
  end
  
  def self.delete(id:)
    Bookmark.sql_delete_record(id: id)
  end
  
  private

  def self.sql_all_records
    db = Database.connect(database: DATABASE)
    db.all_records(table: TABLE)
  end

  def self.sql_add_record(url:, title:)
    db = Database.connect(database: DATABASE)
    db.add_record(
      table: TABLE, 
      in_columns: 'url, title', 
      add_values: "'#{url}', '#{title}'")
  end

  def self.sql_delete_record(id:)
    db = Database.connect(database: DATABASE)
    db.delete_record(
      table: TABLE, 
      where_column: 'id' , 
      contains_value: id)
  end

  # Instance Methods

  public

  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end
end
