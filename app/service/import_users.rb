class ImportUsers

  IDX_TITLE = 2
  IDX_FIRST_NAME = 4
  IDX_LAST_NAME= 3
  IDX_TABLE = 5

	def self.import(file_path)
		book = Roo::Excelx.new(file_path)
		book.default_sheet = 'Gala Charite 30 Nov13'

    for line in 7..book.last_row do
      break if book.cell(line, IDX_FIRST_NAME).nil? && book.cell(line, IDX_LAST_NAME).nil?

      title = book.cell(line, IDX_TITLE)
      first_name = book.cell(line, IDX_FIRST_NAME)
      last_name = book.cell(line, IDX_LAST_NAME)
      sort_order = book.cell(line, IDX_TABLE).to_i
      table_name = "Table #{sort_order}"

      unless sort_order == 0
        table = UserGroup.where(name: table_name).first
        if table.blank?
          table = UserGroup.create(name: table_name, sort_order: sort_order)
        end

        user = User.where(first_name: first_name, last_name: last_name).first
        if user.blank?
          pin = 1000 + rand(8999)
          User.create(title: title, first_name: first_name, last_name: last_name, user_group: table, pin: pin)
        else
          user.update_attributes!(title: title, first_name: first_name, last_name: last_name, user_group: table)
        end
      end
    end

	end

end