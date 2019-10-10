require 'pg'

class Database
  TEST_SUFFIX = '_test'
  
  def self.connect(database:)
    Database.new(database: database)
  end

  def initialize(database:)
    @db_name = database
    @db_name += TEST_SUFFIX if test?
    @connection = PG.connect(dbname: @db_name)
  end
  
  def all_records(table:)
    sql = "SELECT * FROM #{table};"
    data = run_sql(sql: sql)
  end

  def add_record(table:, add_values:, in_columns:, return_data: true)
    sql = "INSERT INTO #{table} (#{in_columns}) VALUES (#{add_values})"
    sql += " RETURNING *" if return_data == true
    run_sql(sql: sql)
  end

  def delete_record(table:, where_column:, contains_value:)
    sql = "DELETE FROM #{table} WHERE #{where_column} = #{contains_value};"
    run_sql(sql: sql)
  end

  def edit_record(table:, where_id:, url:, title:)
    sql = "UPDATE #{table} SET title = '#{title}', url = '#{url}' WHERE id = '#{where_id}'"
    run_sql(sql: sql)
  end

  private

  def run_sql(sql:)
    @connection.exec(sql)
  end

  def test?
    ENV['ENVIRONMENT'] == 'test'
  end
end
