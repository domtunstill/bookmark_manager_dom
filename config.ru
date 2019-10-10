require_relative './app'

if ENV['ENVIRONMENT'] = 'test'
  Database.setup(database: 'bookmark_manager_test')
else
  Database.setup(database: 'bookmark_manager')
end

run BookmarkManager