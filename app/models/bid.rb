class Bid < ActiveRecord::Base
  
  MINIMUM_INCREMENT = 10

  belongs_to :item
  belongs_to :user

  def self.place(item, user, price)
  	previous_bid = Bid.where(item: item).order('timestamp desc').first
    if item.start_price > price
      raise 'Price cannot be lower than start price'
    elsif previous_bid.present? && previous_bid.price >= price
      raise 'Asked price is to low'
    elsif Time.now > Preference.end_time
      raise 'Auction has ended'
    else
      return Bid.create!(user: user, item: item, price: price, timestamp: Time.now)
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
