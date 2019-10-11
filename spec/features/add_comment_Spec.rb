feature 'bookmark comments' do
  scenario 'add comment to existing bookmark' do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    id = bookmark.id
    visit '/'
    within("div#bookmark-#{id}") {
      click_link('New Comment')
      fill_in 'comment', with: "Test Comment"
      click_button("Submit")
    }
    expect(page).to have_link 'Google', href: 'http://www.google.com'
    expect(page).to have_content("Test Comment")
  end
end
