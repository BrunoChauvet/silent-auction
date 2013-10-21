class Preference < ActiveRecord::Base
	def self.end_time
    end_time_preference = Preference.where(name: 'END_TIME').first
    DateTime.strptime(end_time_preference.value, '%Y-%m-%d %H:%M:%S')
  end

  def as_json(options={})
    {
      name: name,
      value: value
    }
  end
end
