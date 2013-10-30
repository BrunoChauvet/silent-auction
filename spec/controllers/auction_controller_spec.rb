require 'spec_helper'

describe AuctionController do
  before do
    @table1 = UserGroup.create(name: 'Table 1')

    @jsmith = User.create(user_group: @table1, title: 'Mr', first_name: 'John', last_name: 'Smith')
    @lmoore = User.create(user_group: @table1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore')

    experiences = Category.create(name: 'Experiences')
    electronics = Category.create(name: 'Electronics')

    @item1 = Item.create(category: experiences, code: '101', name: 'Vespa 12CV', description: 'Brand new Vespa 12CV from our sponsors')
    @item2 = Item.create(category: electronics, code: '102', name: 'Coffee Machine', description: 'Breville coffee machine with 2 years waranty')
    @item3 = Item.create(category: experiences, code: '201', name: 'Tahiti Escape', description: 'Holiday all inclusive package to french polynesia')

    @bid1 = Bid.create(user: @jsmith, item: @item1, price: 3500, timestamp: Time.now)
    @bid2 = Bid.create(user: @jsmith, item: @item2, price: 210, timestamp: Time.now - 1.minute)
    @bid3 = Bid.create(user: @lmoore, item: @item2, price: 220, timestamp: Time.now)
  end

  describe "#index" do
    it "returns the auction page on HTML requests" do
      get :index, format: :html

      response.should render_template('auction/index')
    end

    it "returns the current bids in json format" do
      get :index, format: :json

      response.body.should eql([
          {item: @item1, bid: @bid1, user: @jsmith},
          {item: @item2, bid: @bid3, user: @lmoore},
          {item: @item3, bid: nil, user: nil}].to_json)
    end

    it "returns the current bids in json format" do
      get :index, format: :json

      response.body.should eql([
          {item: @item1, bid: @bid1, user: @jsmith},
          {item: @item2, bid: @bid3, user: @lmoore},
          {item: @item3, bid: nil, user: nil}].to_json)
    end
  end

  describe "#amount_raised" do
    it "returns the auction page on HTML requests" do
      get :amount_raised, format: :json

      response.body.should eql({amount_raised: (@bid1.price + @bid3.price)}.to_json)
    end
  end

end
