require './app'


feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: "bookmark_manager_test")
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.google.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.twitter.com');")
    
    visit('/bookmarks')

    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.twitter.com"
  end
end