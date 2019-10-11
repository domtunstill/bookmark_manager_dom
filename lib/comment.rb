class Comment
  def self.create(bookmark_id:, comment:)
    record = Database.query("INSERT INTO comments(bookmark_id, contents) VALUES (#{bookmark_id}, '#{comment}') RETURNING *").first
    # record = Database.add_record(table: 'comments', add_values: "#{bookmark_id}, '#{comment}'", in_columns: "bookmark_id, contents").first
    p Comment.new(id: record['id'], bookmark_id: record['bookmark_id'], contents: record['contents'])
  end

  def self.where(bookmark_id:)
    results = Database.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id}")
    results.map do |result|
      Comment.new(id: result['id'], bookmark_id: result['bookmark_id'], contents: result['contents'])
    end
  end

  attr_reader :id, :bookmark_id, :contents

  def initialize(id:, bookmark_id:, contents:)
    @id = id
    @bookmark_id = bookmark_id
    @contents = contents
  end
end
