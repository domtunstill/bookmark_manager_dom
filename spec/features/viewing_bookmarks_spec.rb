require './app'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: "bookmark_manager_test")
    connection.exec("INSERT INTO bookmarks (title, url) VALUES('Google', 'http://www.google.com');")
    connection.exec("INSERT INTO bookmarks (title, url) VALUES('Makers Academy', 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks (title, url) VALUES('Twitter', 'http://www.twitter.com');")
    
    visit('/bookmarks')

    expect(page).to have_link 'Google', href: 'http://www.google.com'
    expect(page).to have_link 'Makers Academy', href: 'http://www.makersacademy.com'
    expect(page).to have_link 'Twitter', href: 'http://www.twitter.com'
  end
end

feature 'Adding bookmarks' do
  scenario 'A user can add bookmarks' do
    visit('/bookmarks')
    fill_in 'url', :with => "http://www.google.com"
    fill_in 'title', :with => "Google"
    click_button("Add Bookmark")

    expect(page).to have_link 'Google', href: 'http://www.google.com'
  end
end
