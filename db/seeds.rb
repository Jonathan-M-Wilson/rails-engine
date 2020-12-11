require 'csv'

# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/

ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.reset_pk_sequence!(table)
end

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_test db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)


CSV.foreach('./db/data/items.csv', headers: true) do |row|
  Item.create!(id: row["id"].to_i,
               unit_price: (row["unit_price"].to_i * 0.01).round(2),
               merchant_id: row["merchant_id"].to_i,
               description: row["description"],
               name: row["name"],
               created_at: row["created_at"],
               updated_at: row["updated_at"])
end
# TODO
# - Import the CSV data into the Items table
# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
