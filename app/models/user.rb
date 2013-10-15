class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  belongs_to :user_group
  has_many :bids

  def as_json(options={})
    {
      id: id,
      title: title,
      first_name: first_name,
      last_name: last_name
    }
  end
end
