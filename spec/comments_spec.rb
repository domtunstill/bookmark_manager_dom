require 'comments'

describe Comments do
  describe '.create' do
    it 'adds a comment to the database' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      id = connection.exec("INSERT INTO bookmarks(url, title) VALUES('test', 'test') RETURNING id").first['id']
      Comments.create(bookmark_id: id, comment: "Test Comment")
      comment = connection.exec("SELECT * FROM comments WHERE bookmark_id = #{id}").first
      expect(comment['contents']).to eq "Test Comment"
    end
  end
end
