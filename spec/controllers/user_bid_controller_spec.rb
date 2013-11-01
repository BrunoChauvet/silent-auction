require 'spec_helper'

describe UserBidController do
  before do
    @table1 = UserGroup.create(name: 'Table 1')

    @jsmith = User.create(user_group: @table1, title: 'Mr', first_name: 'John', last_name: 'Smith')
    @lmoore = User.create(user_group: @table1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore')

    experiences = Category.create(name: 'Experiences')

    @item1 = Item.create(category: experiences, code: '101', start_price: 250, name: 'Owner')
    @item2 = Item.create(category: experiences, code: '102', start_price: 150, name: 'Outbidded')
    @item3 = Item.create(category: experiences, code: '103', start_price: 200, name: 'No bid')
    @item4 = Item.create(category: experiences, code: '104', start_price: 100, name: 'Start price')

    @bid1 = Bid.create(user: @jsmith, item: @item1, price: 250, timestamp: Time.now)
    @bid2 = Bid.create(user: @jsmith, item: @item2, price: 210, timestamp: Time.now - 1.minute)
    @bid3 = Bid.create(user: @lmoore, item: @item2, price: 220, timestamp: Time.now)
    @bid4 = Bid.create(user: @lmoore, item: @item3, price: 250, timestamp: Time.now)
  end

  describe "#list_items" do
    it "returns the items with current user bid status" do
      sign_in @jsmith

      get :list_items, format: :json

      response.body.should eql([
          {item: @item1, price: @bid1.price, status: 'owner'},
          {item: @item2, price: @bid3.price, status: 'outbidded'},
          {item: @item3, price: @bid4.price, status: 'none'},
          {item: @item4, price: @item4.start_price, status: 'start-price'}].to_json)
    end
  end

end
