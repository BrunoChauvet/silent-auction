class User < ActiveRecord::Base
  devise :database_authenticatable

  belongs_to :user_group
  has_many :bids

  def admin?
    admin
  end

  def encrypted_password
    return pin
  end

  def as_json(options={})
    {
      id: id,
      title: title,
      first_name: first_name,
      last_name: last_name
    }
  end
end
