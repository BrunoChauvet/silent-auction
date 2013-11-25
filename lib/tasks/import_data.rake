desc 'Import items and tables'
task :import_data => [:environment] do
  puts "Importing data"
  ImportUsers.import 'public/gala_tables.xlsx'
  puts "Imported #{User.count()} users"
  ImportItems.import 'public/gala_content.xlsx'
  puts "Imported #{Item.count()} items"
end
