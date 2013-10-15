Warden::Strategies.add(:pin_strategy) do 
  def valid?
    return params[:pin].present?
  end

  def authenticate!
    user = User.find(params[:id])
    if user.pin == params[:pin]
      success!(user)
    else
      fail!('Invalid Pin')
    end
  end
end
