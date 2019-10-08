require './app'

feature 'Adding bookmarks' do
  scenario 'A user can add bookmarks' do
    visit('/')
    fill_in 'url', with: "http://www.google.com"
    fill_in 'title', with: "Google"
    click_button("Add Bookmark")

    expect(page).to have_link 'Google', href: 'http://www.google.com'
  end
end
