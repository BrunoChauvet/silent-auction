require 'spreadsheet'

class ImportUsers
	book = Spreadsheet.open('/home/bruno/Desktop/gala_tables.xls')
	sheet1 = book.worksheet('Sheet1')
	sheet1.each do |row|
	  break if row[1].nil?
	  title = row[1]
    first_name = row[2]
    last_name = row[3]
    table_name = row[4]

    puts "Processing #{title} #{first_name} #{last_name} => #{table_name}"

    # Table.where(name: table_name).first_or_initalize
	end
end