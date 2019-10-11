require 'bookmark'
require 'database_helpers'

describe Bookmark do
  let(:tag) { double(:tag, id: 1 ) }
  let(:comment_class) { double(:comment_class) }
  let(:tag_bookmark_class) { double(:tag_bookmark_class) }

  subject(:bookmark) {
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    Bookmark.new(id: bookmark.id, url: bookmark.url, title: bookmark.title, comment_class: comment_class, tag_class: tag_class, tag_bookmark_class: tag_bookmark_class)
   }

  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.destroyallsoftware.com', 'DAS');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google');")

      bookmarks = Bookmark.all

      expect(bookmarks[0].title).to eq('Makers')
      expect(bookmarks[0].url).to eq('http://www.makersacademy.com')

      expect(bookmarks[1].title).to eq('DAS')
      expect(bookmarks[1].url).to eq('http://www.destroyallsoftware.com')

      expect(bookmarks[2].title).to eq('Google')
      expect(bookmarks[2].url).to eq('http://www.google.com')
      # expect(bookmarks).to include('http://www.destroyallsoftware.com')
      # expect(bookmarks).to include('http://www.google.com')

    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Google'
      expect(bookmark.url).to eq 'http://www.google.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark_1 = connection.exec("
        INSERT INTO bookmarks (url, title)
        VALUES ('http://www.google.com', 'Google')
        RETURNING * ;")

      bookmark_2 = connection.exec("
        INSERT INTO bookmarks (url, title)
        VALUES ('http://www.makers.tech', 'Makers')
        RETURNING * ;")

      expect(Bookmark.all.length).to eq 2
      Bookmark.delete(id: bookmark_1.first['id'])
      expect(Bookmark.all.length).to eq 1

    end
  end

  describe '.edit' do
    it 'edits a bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark = connection.exec("
        INSERT INTO bookmarks (url, title)
        VALUES ('http://www.google.com', 'Google')
        RETURNING * ;"
      )

      id_old =  bookmark.first['id']

      Bookmark.edit(id: id_old, title: 'Lougle', url: 'http://www.Lougle.com')
      bookmarks = Bookmark.all
      expect(bookmarks.first.id).to eq id_old
      expect(bookmarks.first.title).to eq 'Lougle'
      expect(bookmarks.first.url).to eq 'http://www.Lougle.com'
    end

    it "doesn't edit a bookmark, if URL and title remain unchanged" do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      bookmark = connection.exec("
        INSERT INTO bookmarks (url, title)
        VALUES ('http://www.google.com', 'Google')
        RETURNING * ;"
      )

      id_old =  bookmark.first['id']

      returnvalue = Bookmark.edit(
        id: id_old,
        title: 'Google',
        url: 'http://www.Google.com'
      )
      expect(returnvalue).to eq false
    end
  end

  describe '#add_comment' do
    it 'adds a comment to the selected bookmark' do
      expect(comment_class).to receive(:create).with(bookmark_id: bookmark.id, comment: "Test Comment")
      bookmark.add_comment("Test Comment")
    end
  end

  describe '#comments' do
    context 'given a bookmark id' do
      it 'returns all comments' do
        expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
        bookmark.comments
      end
    end
  end

  describe '#add_tag' do
    it 'adds a tag to the selected bookmark' do
      expect(tag_class).to receive(:create).with(name: "Test Tag") {tag}
      expect(tag_bookmark_class).to receive(:tag_bookmark).with(bookmark_id: bookmark.id, tag_id: tag.id)
      bookmark.add_comment("Test Comment")
    end
  end

  describe '#tag' do
    it 'returns tags on the selected bookmark' do
      expect(tag_bookmark_class).to receive(:where).with(column: 'bookmark_id', bookmark.id)
    end
  end

end
