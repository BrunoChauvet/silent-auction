class ImportItems

  IDX_CODE = 1
  IDX_NAME = 2
  IDX_START_PRICE = 7

  def self.import(file_path)
  	book = Roo::Excelx.new(file_path)
    book.default_sheet = 'Silent AUCTION'

    category = nil

    for line in 2..book.last_row do
      first_cell = book.cell(line, 1)
      break if first_cell.nil?

      if first_cell.is_a? String
        category_name = first_cell
        category = Category.where(name: category_name).first_or_create
      else
        code = book.cell(line, IDX_CODE).to_i.to_s
        name = book.cell(line, IDX_NAME)
        start_price = book.cell(line, IDX_START_PRICE) || 0

        item = Item.where(code: code).first
        if item.blank?
          item = Item.create(code: code, name: name, start_price: start_price, category: category)
        else
          item.update_attributes!(name: name, start_price: start_price, category: category)
        end

        if File.exist?("public/items/#{code}.jpg")
          item.image = File.open("public/items/#{code}.jpg")
          item.save
        end
      end
  	end
  end

end