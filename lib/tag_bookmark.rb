require_relative 'database'
require_relative 'bookmark'

class TagBookmark
  def self.tag_bookmark(bookmark_id:, tag_id:)
    Database.query("INSERT INTO bookmark_tags(bookmark_id, tag_id) VALUES(#{bookmark_id}, #{tag_id})")
  end

  def self.where(column:, id:)
    column == 'bookmark_id' ? result_class = self.tag_class : result_class = self.bookmark_class
    result_class == self.tag_class ? find_column = 'tag_id' : find_column = 'bookmark_id'

    results = Database.query("SELECT #{find_column} FROM bookmark_tags WHERE #{column} = #{id}")
    results.map do |result|
      result_class.where(id: result[find_column])
    end
  end
  
  private

  def self.tag_class
    # Tag
  end

  def self.bookmark_class
    Bookmark
  end
end
