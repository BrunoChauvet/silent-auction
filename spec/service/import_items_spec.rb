require 'spec_helper'

describe ImportItems do

  describe "#import" do

    let(:file_path) {'spec/fixtures/gala_content.xlsx'}

    it "should extract the categories" do
      ImportItems.import file_path

      categories = Category.order('name')
      categories.length.should eql(5)
      categories[0].name.should eql('ART')
      categories[1].name.should eql('ELECTRICALS')
      categories[2].name.should eql('EXPERIENCE')
      categories[3].name.should eql('PERSONAL & FAMILY')
      categories[4].name.should eql('SPIRITS & WINES')
    end

    it "should not recreate an existing category" do
      Category.create!(name: 'EXPERIENCE')

      ImportItems.import file_path

      categories = Category.order('name')
      categories.length.should eql(5)
      categories[2].name.should eql('EXPERIENCE')
    end

    it "should extract the items" do
      ImportItems.import file_path

      items = Item.order('code')
      items.length.should eql(36)
      items[0].code.should eql('101')
      items[0].name.should eql('Madame Butterfly  on Sydney Harbour')
      items[0].start_price.should eql(400)
      items[0].bid_increment.should eql(20)
      items[0].category.name.should eql('EXPERIENCE')
      items[0].description.should include('Create a night to remember for yourself and three friends')
      items[0].by.should eql('Manildra')
    end

    it "should update an existing item" do
      category = Category.create!(name: 'OLD CATEGORY')
      Item.create(code: '101', name: 'Old Name', start_price: 100, category: category)

      ImportItems.import file_path

      item = Item.where(code: '101').first
      item.name.should eql('Madame Butterfly  on Sydney Harbour')
      item.start_price.should eql(400)
      item.category.name.should eql('EXPERIENCE')
    end

  end

end
