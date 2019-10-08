require 'pg'

class Database_conn
  DB_NAME  = 'bookmark_manager'
  TEST_SUFFIX = '_test'
  
  def initialize
    @db_name = DB_NAME
    @db_name += TEST_SUFFIX if test?
    @connection = PG.connect(dbname: @db_name )
  end
  
  def all_records(table)
    sql = "SELECT * FROM #{table};"
    data = run_sql(sql)
    return data
  end
  
  def save_value(table, column, value)
    sql = "INSERT INTO #{table} (#{column}) VALUES ('#{value}');" #check if quotes needed
    run_sql(sql)
  end
  
  private

  def run_sql(sql)
    @connection.exec(sql)
  end

  def test?
    ENV['ENVIRONMENT'] == 'test'
  end
end