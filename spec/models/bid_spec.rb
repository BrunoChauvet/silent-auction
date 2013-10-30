require 'spec_helper'

describe Bid do
  before do
    Preference.create(name: 'END_TIME', value: (Time.now + 1.day).strftime("%Y-%m-%d %H:%M:%S%z"))

    table = UserGroup.create(name: 'Table')
    @jsmith = User.create(user_group: table, title: 'Mr', first_name: 'John', last_name: 'Smith')
    @item = Item.create(name: 'Vespa 12CV', description: 'Brand new Vespa 12CV from our sponsors', start_price: 500)
  end

  describe "#place" do
    it "raises an error when price is lower than item start price" do
      expect { Bid.place(@item, @jsmith, 490) }.to raise_error
    end

    it "raises an error when price is lower than previous bid price" do
      @bid = Bid.create(user: @jsmith, item: @item, price: 520, timestamp: Time.now)

      expect { Bid.place(@item, @jsmith, 510) }.to raise_error
    end

    it "raises an error when bidding after auction end time" do
      Preference.where(name: 'END_TIME').first.update_attributes!(value: (Time.now - 1.second).strftime("%Y-%m-%d %H:%M:%S%z"))

      expect { Bid.place(@item, @jsmith, 510) }.to raise_error
    end

    it "successfully places a bid" do
      expect { Bid.place(@item, @jsmith, 510) }.to_not raise_error
    end
  end

end
