feature 'URL Validation' do
  scenario 'user submits invalid URL' do
    visit '/'
    visit('/')
    fill_in 'url', with: "www.google.com"
    fill_in 'title', with: "Google 2"
    click_button("Add Bookmark")

    expect(page).to have_content("You must submit a valid URL.")
    expect(page).to_not have_link("Google 2")
  end
end