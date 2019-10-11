require 'comment'

describe Comment do
  describe '.create' do
    it 'adds a comment to the database' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      id = connection.exec("INSERT INTO bookmarks(url, title) VALUES('test', 'test') RETURNING id").first['id']
      Comment.create(bookmark_id: id, comment: "Test Comment")
      comment = connection.exec("SELECT * FROM comments WHERE bookmark_id = #{id}").first
      expect(comment['contents']).to eq "Test Comment"
    end
  end
  
  describe '.where' do
    context 'given a bookmark id' do
      it 'returns a list of comments' do
        connection = PG.connect(dbname: 'bookmark_manager_test')
        id = connection.exec("INSERT INTO bookmarks(url, title) VALUES('test', 'test') RETURNING id").first['id']
        comment = connection.exec("INSERT INTO comments(bookmark_id, contents) VALUES (#{id}, 'Test Comment') RETURNING *")

        expect(Comment.where(bookmark_id: id).first.contents).to eq "Test Comment"
      end
    end
  end
end
