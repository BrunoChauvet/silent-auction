class Item < ActiveRecord::Base
	belongs_to :category
  has_many :bids

	mount_uploader :image, ImageUploader

	def as_json(options={})
    {
      id: id,
      name: name,
      description: description,
      code: code,
      image: image.url,
      start_price: start_price
    }
  end
end
