require 'mysql2'
require 'dotenv/load'

def create_db_client
    client = Mysql2::Client.new(
    :host => "127.0.0.1",
    :username => "root",
    :password => "root",
    :database => ENV['DB_NAME']
    )
end