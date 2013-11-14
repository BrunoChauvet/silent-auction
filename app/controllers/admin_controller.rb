class AdminController < ApplicationController

  def index

  end

  def import_items
    ImportItems.import 'public/gala_content.xls'
    flash[:message] = "Items have been imported"
    redirect_to admin_path
  end

  def import_users
    ImportUsers.import 'public/gala_tables.xls'
    flash[:message] = "Tables have been imported"
    redirect_to admin_path
  end

end
