class Bid < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def as_json(options={})
    {
      id: id,
      price: price,
      timestamp: timestamp
    }
  end
end
