require 'pg'

def setup_test_database
  # p "setting up an empty test database..."

  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks;")
end