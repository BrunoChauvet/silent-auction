class AdminController < ApplicationController

  def index

  end

  def import_items
    ImportItems.import 'public/gala_content.xlsx'
    flash[:message] = "Items have been imported"
    redirect_to admin_path
  end

  def import_users
    ImportUsers.import 'public/gala_tables.xls'
    flash[:message] = "Tables have been imported"
    redirect_to admin_path
  end

  def import_items_google_drive
    begin
      session = GoogleDrive.login(params[:username], params[:password])
      file = session.file_by_title("DESIGN - Contenu Booklet")
      file.export_as_file("tmp/gala_content.xlsx", "xlsx")
      ImportItems.import 'tmp/gala_content.xlsx'   

      flash[:message] = "Items have been imported"
      redirect_to admin_path
    rescue Exception => e
      flash[:error] = "Cannot connect to Google Drive: #{e.message}"
      redirect_to admin_path
    end
  end

end
