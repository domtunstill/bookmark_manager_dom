require 'tag'

describe Tag do

  let(:tag_bookmark_class) { double(:tag_bookmark_class) }

  subject(:tag) {
    tag = Tag.create(name: 'Test tag')
    Tag.new(id: tag.id, name: tag.name, tag_bookmark_class: tag_bookmark_class)
   }

  describe '.create' do
    it 'creates a tag in the tags table and assigns ' do
      tag = Tag.create(name: "Test Tag")
      expect(tag.name).to eq "Test Tag"
    end
  end

  describe '.where' do
    it 'returns the tags relevant to the bookmark' do
      tag = Tag.create(name: "Test Tag")
      expect(Tag.where(id: tag.id).name).to eq "Test Tag"
    end
  end

  describe '#bookmarks' do
    it 'returns the bookmarks relevant to the tag' do
      expect(tag_bookmark_class).to receive(:where).with(column: 'tag_id', id: tag.id)
      tag.bookmarks
    end
  end

end
