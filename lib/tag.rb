class Tag

  def self.create(name:)
    record = Database.query("INSERT INTO tags (name) VALUES ('#{name}') RETURNING *").first
    Tag.new(id: record['id'], name: record['name'])
  end

  def self.where(id:)
    record = Database.query("SELECT * FROM tags WHERE id = #{id}").first
    Tag.new(id: record['id'], name: record['name'])
  end

  def bookmarks
    tag_bookmark_class.where(column'tag_id', id: @id)
  end

  attr_reader :id, :name

  def initialize(id:, name:, tag_bookmark_class: TagBookmark)
    @id = id
    @name = name
    @tag_bookmark_class = tag_bookmark_class
  end

end
