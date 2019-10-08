require './app'

feature 'Deleting bookmarks' do
  scenario 'A user can delete bookmarks' do
    visit('/')
    fill_in 'url', with: "http://www.google.com"
    fill_in 'title', with: "Google"
    click_button("Add Bookmark")
    expect(page).to have_link 'Google', href: 'http://www.google.com'

    find_button('X').click
  
    expect(page).not_to have_link 'Google', href: 'http://www.google.com'

  end
end