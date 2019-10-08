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

  def save_value(table, columns, values, return_data = true)
    sql = "INSERT INTO #{table} (#{columns}) VALUES (#{values})"
    sql += " RETURNING *" if return_data == true
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
