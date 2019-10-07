require 'pg'

class Connection
  DB_NAME  = 'bookmark_manager'
  TEST_SUFFIX = '_test'
  
  def initialize
    @db_name = DB_NAME
    @db_name += TEST_SUFFIX if test?
    @connection = PG.connect(dbname: @db_name )
  end

  def run_sql(sql)
    @connection.exec(sql)
  end

private

  def test?
    ENV['ENVIRONMENT'] == 'test'
  end
end