class Comments

  def self.create(bookmark_id:, comment:)
    record = Database.add_record(table: 'comments', add_values: "#{bookmark_id}, '#{comment}'", in_columns: "bookmark_id, contents").first
    Comments.new(id: record['id'], bookmark_id: record['bookmark_id'], contents: record['contents'])
  end

  attr_reader :id, :bookmark_id, :contents

  def initialize(id:, bookmark_id:, contents:)
    @id = id
    @bookmark_id = bookmark_id
    @contents = contents
  end

end
