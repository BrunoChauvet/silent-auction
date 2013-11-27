class ImportItems

  IDX_CODE = 1
  IDX_NAME = 2
  IDX_START_PRICE = 7
  IDX_BY = 9
  IDX_DESCRIPTION = 11
  IDX_CATEGORY = 10

  def self.import(file_path)
  	book = Roo::Excelx.new(file_path)
    book.default_sheet = 'Silent AUCTION'

    category = nil

    for line in 2..book.last_row do
      break if book.cell(line, IDX_CODE).nil? && book.cell(line, IDX_CATEGORY).nil?

      if book.cell(line, IDX_CODE).nil?
        category_name = book.cell(line, IDX_CATEGORY)
        category = Category.where(name: category_name).first_or_create
      else
        code = book.cell(line, IDX_CODE).to_i.to_s
        name = book.cell(line, IDX_NAME)

        if book.cell(line, IDX_START_PRICE).is_a? Float
          start_price = book.cell(line, IDX_START_PRICE).to_i
        else
          start_price = 0
        end

        by = book.cell(line, IDX_BY)
        unless by.blank?
          by.gsub!('Courtesy of', '')
          by.gsub!(':', '')
          by.gsub!('.', '')
          by.gsub!('-', '')
          by.gsub!('\'', '')
          by.lstrip!
        end
        description = book.cell(line, IDX_DESCRIPTION)

        bid_increment = start_price >= 1000 ? 100 : start_price >= 500 ? 50 : 20

        item = Item.where(code: code).first
        if item.blank?
          item = Item.create(code: code, name: name, description: description, start_price: start_price, bid_increment: bid_increment, by: by, category: category)
        else
          item.update_attributes!(name: name, description: description, start_price: start_price, bid_increment: bid_increment, by: by, category: category)
        end

        if File.exist?("#{Rails.root}/public/items/#{code}.jpg")
          item.image = File.open("#{Rails.root}/public/items/#{code}.jpg")
          item.save
        end

        by.split(/\W+/).each do |word|
          if File.exist?("#{Rails.root}/public/sponsors/#{word}.jpg")
            item.sponsor = File.open("#{Rails.root}/public/sponsors/#{word}.jpg")
            item.save
            break
          end
        end unless by.blank?
      end
  	end
  end

end