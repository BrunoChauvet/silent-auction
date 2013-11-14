class AdminController < ApplicationController

  def index

  end

  def import_items
  	ImportItems.import 'public/gala_content.xls'
    flash[:message] = "Items have been imported"
    redirect_to admin_path
  end

end
