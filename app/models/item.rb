class Item < ActiveRecord::Base
	belongs_to :category
  has_many :bids

	mount_uploader :image, ImageUploader
  mount_uploader :sponsor, ImageUploader

  def minimum_price
    previous_bid = Bid.where(item: self).order('timestamp desc').first
    if previous_bid.present?
      return previous_bid.price + bid_increment
    else
      return start_price
    end
  end

  def current_price
    previous_bid = Bid.where(item: self).order('timestamp desc').first
    if previous_bid.present?
      return previous_bid.price
    else
      return start_price
    end
  end

	def as_json(options={})
    {
      id: id,
      name: name,
      description: description,
      code: code,
      category: category.name.split.map(&:capitalize).join(' '),
      category_class: category.name.tr('^A-Za-z0-9', '').downcase,
      image: image.thumb.url || 'images/ufe_logo.png',
      start_price: start_price
    }
  end
end
