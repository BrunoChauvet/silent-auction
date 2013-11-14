require 'spreadsheet'

class ImportItems

  IDX_CODE = 0
  IDX_NAME = 2
  IDX_START_PRICE = 4

  def self.import(file_path)
  	book = Spreadsheet.open(file_path)
  	sheet = book.worksheet('Silent AUCTION')

    category = nil

  	sheet.each_with_index do |row, index|
      next if index == 0
      break if row[0].nil?

      if row[0].is_a? String
        category_name = row[0]
        category = Category.where(name: category_name).first_or_create
      else
        code = row[IDX_CODE]
        name = row[IDX_NAME]
        start_price = row[IDX_START_PRICE] || 0

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