require './app'

feature 'Deleting bookmarks' do
  scenario "A user can delete a bookmark" do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/'
    id = bookmark.id

    within("div#bookmark-#{id}") do
      click_button('X')
    end

    expect(page).not_to have_link 'Google', href: 'http://www.google.com'
  end
end