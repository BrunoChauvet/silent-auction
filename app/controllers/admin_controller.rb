class AdminController < ApplicationController
  before_filter :authenticate_admin!
  layout 'empty', only: [:user_cards]

  def index

  end

  def user_cards
    @users = User.all.joins(:user_group).order('user_groups.sort_order ASC, last_name asc, first_name ASC')  
    respond_to do |format|
      format.html
      format.pdf {
        pdf = ExportUsers.export_user_cards_pdf(@users)
        send_data pdf.render, type: "application/pdf", disposition: "inline"
        return
      }
    end
  end

  def highest_bids
    csv = ExportUsers.export_highest_bids
    render text: csv
  end

  def import_items
    ImportItems.import 'public/gala_content.xlsx'
    flash[:message] = "Items have been imported"
    redirect_to admin_path
  end

  def import_users
    ImportUsers.import 'public/gala_tables.xlsx'
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

  def import_tables_google_drive
    begin
      session = GoogleDrive.login(params[:username], params[:password])
      file = session.file_by_title("Guest List")
      file.export_as_file("tmp/gala_tables.xlsx", "xlsx")
      ImportUsers.import 'tmp/gala_tables.xlsx'   

      flash[:message] = "Tables have been imported"
      redirect_to admin_path
    rescue Exception => e
      flash[:error] = "Cannot connect to Google Drive: #{e.message}"
      redirect_to admin_path
    end
  end

end
