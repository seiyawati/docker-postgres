# /Users/seiya/.rbenv/shims/ruby

require 'pg'
require 'yaml'

dbconf = YAML.load_file("./database.yml")["db"]["development"]
# connect = PG::connect(host: "localhost", user: "seiya", password: "secret", dbname: "shop", port: "5432") 

begin
  connect = PG::connect(dbconf)
rescue
  abort "Error: failed to connect to DB."
end

begin
  connect.transaction do |c|
    result = c.exec("select * from shohin")
    result.each do |row|
      puts "#{row["shohin_mei"]}は#{row["hanbai_tanka"]}円です。"
    end
  end
rescue PG::Error => e
  puts e.message, e.result.error_field(PG::Result::PG_DIAG_SQLSTATE)
ensure
  connect.finish
end
