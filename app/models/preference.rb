class Preference < ActiveRecord::Base
	def as_json(options={})
    {
      name: name,
      value: value
    }
  end
end
