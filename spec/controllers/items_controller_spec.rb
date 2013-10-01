require 'spec_helper'

describe ItemsController do
  before do
    @table1 = UserGroup.create(name: 'Table 1')

    @jsmith = User.create(user_group: @table1, title: 'Mr', first_name: 'John', last_name: 'Smith')
    @lmoore = User.create(user_group: @table1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore')

    @item1 = Item.create(name: 'Vespa 12CV', description: 'Brand new Vespa 12CV from our sponsors', start_price: 500)
    @item2 = Item.create(name: 'Coffee Machine', description: 'Breville coffee machine with 2 years waranty', start_price: 100)
    @item3 = Item.create(name: 'Tahiti Escape', description: 'Holiday all inclusive package to french polynesia', start_price: 700)

    @bid1 = Bid.create(user: @jsmith, item: @item1, price: 3500, timestamp: Time.now)
    @bid2 = Bid.create(user: @jsmith, item: @item2, price: 210, timestamp: Time.now - 1.minute)
    @bid3 = Bid.create(user: @lmoore, item: @item2, price: 220, timestamp: Time.now)
  end

  describe "#index" do
    it "renders the list of all items" do
      get :index, user_id: @jsmith.id

      assigns(:items).should include(@item1, @item2, @item3)
    end
  end

  describe "#show" do
    it "returns the specified item and user" do
      get :show, format: :html, id: @item1.id, user_id: @jsmith.id

      assigns(:item).should eql(@item1)
      assigns(:user).should eql(@jsmith)
    end

    it "returns the specified item and user in json format" do
      get :show, format: :json, id: @item1.id, user_id: @jsmith.id

      response.body.should eql({item: @item1, user: @jsmith, bid: @bid1}.to_json)
    end
  end

  describe "#place_bid" do
    it "places a bid with a valid price" do
      post :place_bid, format: :json, id: @item2.id, user_id: @jsmith.id, price: 230

      parsed_body = JSON.parse(response.body)
      parsed_body['success'].should be_true
      parsed_body['bid']['price'].to_d.should eql(230)
    end

    it "rejects bids with a price lower than current bid price" do
      post :place_bid, format: :json, id: @item2.id, user_id: @jsmith.id, price: 220

      parsed_body = JSON.parse(response.body)
      parsed_body['success'].should be_false
    end

    it "rejects bids with a price lower than start price" do
      post :place_bid, format: :json, id: @item3.id, user_id: @jsmith.id, price: 690

      parsed_body = JSON.parse(response.body)
      parsed_body['success'].should be_false
    end
  end
end
