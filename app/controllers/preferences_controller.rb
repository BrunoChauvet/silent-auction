class PreferencesController < ApplicationController
	def index
    @preferences = Preference.find(:all, order: :name)
  end

  def update
    preference = Preference.find(params[:id])
    preference.update_attributes!(params)
  end
end
