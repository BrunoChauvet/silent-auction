class Bid < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :user
  belongs_to :placed_by, class_name: "User", :foreign_key => "placed_by_id"

  def self.place(item, user, price, placed_by=nil)
  	previous_bid = Bid.where(item: item).order('timestamp desc').first
    if item.start_price > price
      raise 'Price cannot be lower than start price'
    elsif previous_bid.present? && previous_bid.price >= price
      raise 'Asked price is to low'
    elsif Time.now > Preference.end_time
      raise 'Auction has ended'
    else
      return Bid.create!(user: user, item: item, price: price, timestamp: Time.now, placed_by: placed_by)
    end
  end

  def as_json(options={})
    {
      id: id,
      price: price,
      timestamp: timestamp
    }
  end
end
