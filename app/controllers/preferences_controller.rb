class PreferencesController < ApplicationController
	def index
    @preferences = Preference.find(:all, order: :name)
  end

  def show
    render json: Preference.find(params[:id])
  end

  def update
    preference = Preference.find(params[:id])
    preference.update_attributes!(params)
  end
end
