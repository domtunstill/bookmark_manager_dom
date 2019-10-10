require './app'

feature "Editing bookmarks" do
  scenario "Users can edit the bookmarks" do
    bookmark = Bookmark.create(url: 'http://www.google.com', title: 'Google')
    visit '/'
    id = bookmark.id

    within("div#bookmark-#{id}") do
      click_button('Edit')
      fill_in 'url', with: 'http://www.Lougle.com'
      fill_in 'title', with: 'Lougle'
      click_button('Submit Change')
      expect(page).to have_content('Lougle')
    end

  end
end