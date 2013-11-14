class ImportUsers

  IDX_TITLE = 0
  IDX_FIRST_NAME = 1
  IDX_LAST_NAME= 2
  IDX_TABLE = 3

	def self.import(file_path)
		book = Spreadsheet.open(file_path)
		sheet = book.worksheet(0)

		sheet.each_with_index do |row, index|
      next if index == 0
      break if row[IDX_FIRST_NAME].nil? && row[IDX_LAST_NAME].nil?

		  break if row[IDX_FIRST_NAME].nil?
		  title = row[IDX_TITLE]
	    first_name = row[IDX_FIRST_NAME]
	    last_name = row[IDX_LAST_NAME]
	    sort_order = row[IDX_TABLE]
      table_name = "Table #{row[IDX_TABLE]}"

	    table = UserGroup.where(name: table_name).first
      if table.blank?
        table = UserGroup.create(name: table_name, sort_order: sort_order)
      end

      user = User.where(first_name: first_name, last_name: last_name).first
      if user.blank?
        pin = 1000 + rand(8999)
        user = User.create(title: title, first_name: first_name, last_name: last_name, user_group: table, pin: pin)
      else
        user.update_attributes!(title: title, first_name: first_name, last_name: last_name, user_group: table)
      end
		end
	end

end