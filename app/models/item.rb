class Item < ActiveRecord::Base
	has_many :bids

	mount_uploader :image, ImageUploader

	def as_json(options={})
    {
      id: id,
      name: name,
      description: description,
      image: image.url,
      start_price: start_price
    }
  end
end
