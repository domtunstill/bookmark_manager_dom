feature 'create tags' do
  scenario 'user can create tag for a bookmark' do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    id = bookmark.id
    visit('/')
    within("div#bookmark-#{id}") {
      click_link('Add Tag')
      fill_in 'tag_list', with: "Test Tag"
      click_button("Submit")
    }

    expect(page).to have_link 'Google', href: 'http://www.google.com'
    expect(page).to have_content("Test Tag")

  end
end
