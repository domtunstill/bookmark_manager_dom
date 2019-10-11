require 'tag_bookmark'

describe TagBookmark do
  let(:bookmark_double) { double(:bookmark) }
  let(:bookmark_class) { double(:bookmark_class, where: bookmark_double) }
  let(:tag_double) { double(:tag) }
  let(:tag_class) { double(:tag_class, where: tag_double) }
  
  describe '.tag_bookmark' do
    context 'given a bookmark id and tag id' do
      it 'tags the bookmark' do
        connection = PG.connect(dbname: 'bookmark_manager_test')
        bookmark = connection.exec("INSERT INTO bookmarks(url, title) VALUES ('https://google.com', 'Google') RETURNING *").first
        tag = connection.exec("INSERT INTO tags(name) VALUES ('Fun') RETURNING *").first
        
        TagBookmark.tag_bookmark(bookmark_id: bookmark['id'], tag_id: tag['id'])
        tagged_bookmark = connection.exec("SELECT * FROM bookmark_tags WHERE bookmark_id = #{bookmark['id']}").first
        expect(tagged_bookmark['tag_id']).to eq tag['id']
      end
    end
  end
  
  describe '.where' do
    context 'given a bookmark id' do
      it 'returns a list of associated tags' do
        allow(TagBookmark).to receive(:tag_class) { tag_class }
        connection = PG.connect(dbname: 'bookmark_manager_test')
        bookmark = connection.exec("INSERT INTO bookmarks(url, title) VALUES ('https://google.com', 'Google') RETURNING *").first
        tag = connection.exec("INSERT INTO tags(name) VALUES ('Fun') RETURNING *").first
        TagBookmark.tag_bookmark(bookmark_id: bookmark['id'], tag_id: tag['id'])

        expect(tag_class).to receive(:where).with(id: tag['id'])
        expect(TagBookmark.where(column: 'bookmark_id', id: bookmark['id']).first).to eq tag_double
      end
    end

    context 'given a tag id' do
      it 'returns a list of assiciated bookmarks' do
        allow(TagBookmark).to receive(:bookmark_class) { bookmark_class }
        connection = PG.connect(dbname: 'bookmark_manager_test')
        bookmark = connection.exec("INSERT INTO bookmarks(url, title) VALUES ('https://google.com', 'Google') RETURNING *").first
        tag = connection.exec("INSERT INTO tags(name) VALUES ('Fun') RETURNING *").first
        TagBookmark.tag_bookmark(bookmark_id: bookmark['id'], tag_id: tag['id'])

        expect(bookmark_class).to receive(:where).with(id: bookmark['id'])
        expect(TagBookmark.where(column: 'tag_id', id: tag['id']).first).to eq bookmark_double
      end
    end
  end
end
