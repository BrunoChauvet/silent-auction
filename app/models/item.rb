class Item < ActiveRecord::Base
	belongs_to :category
  has_many :bids

	mount_uploader :image, ImageUploader
  mount_uploader :sponsor, ImageUploader

	def as_json(options={})
    {
      id: id,
      name: name,
      description: description,
      code: code,
      category: category.name.tr('^A-Za-z0-9', '').downcase,
      image: image.thumb.url || 'images/ufe_logo.png',
      start_price: start_price
    }
  end
end
