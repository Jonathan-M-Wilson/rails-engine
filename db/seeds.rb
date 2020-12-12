require 'csv'
Item.destroy_all

# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/


cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

puts 'Importing items.csv'
CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
  Item.create({
      id: row[:id],
      name: row[:name],
      description: row[:description],
      unit_price: row[:unit_price].to_f/100,
      merchant_id: row[:merchant_id],
      created_at: row[:created_at],
      updated_at: row[:updated_at]
    }
  )
end


# Reset ids. When new records are created, it begins at end of table.
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.reset_pk_sequence!(table)
end


puts "All csv files successfully imported!!!"
# TODO
# - Import the CSV data into the Items table
# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
