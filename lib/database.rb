require 'pg'

class DatabaseConn
  TEST_SUFFIX = '_test'
  
  def initialize(database)
    @db_name = database
    @db_name += TEST_SUFFIX if test?
    @connection = PG.connect(dbname: @db_name)
  end
  
  def all_records(table)
    sql = "SELECT * FROM #{table};"
    data = run_sql(sql)
  end

  def save_value(table, column, value)
    sql = "INSERT INTO #{table} (#{column}) VALUES ('#{value}');"
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
