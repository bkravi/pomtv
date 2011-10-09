class UtilitiesController < ApplicationController
  require 'spreadsheet'

  def send_to_reliance
    @utilities = @install_book = InstallBook.find(:all, :order => "Slip_Trans_id", :conditions => ["delete_flag = 0 and NOT Installed"]).paginate(:page => params[:page], :per_page => 20)
    render :layout => "reportlayout"
  end

  def save_reliance
    install_book = InstallBook.find(:all, :order => "Slip_Trans_id", :conditions => ["delete_flag = 0 and NOT Installed"])
    
    list_name = "#{Time.now.to_s.gsub(/[: +]/,'_')}_WorkorderList.xls"
    list_book = Spreadsheet::Workbook.new
    list_sheet = list_book.create_worksheet(:name => "Workorder Details")

    _write_excel(list_sheet, install_book)   

    list_book.write "#{RAILS_ROOT}/public/downloads/#{list_name}"
    list_path = "#{RAILS_ROOT}/public/downloads/#{list_name}"
    send_file list_path, :type => 'application/vnd.ms-excel'
  end

  private
  def _write_excel(list_sheet, install_book)
     row_counter = 0
     list_sheet.row(row_counter).default_format = Spreadsheet::Format.new(:weight=>"bold",:color=>"white",:pattern  => 1,:pattern_fg_color => "blue")
     list_sheet.row(row_counter).insert 0, "Slip Or Trans ID"
     list_sheet.row(row_counter).insert 1, "GSK NO"
     list_sheet.row(row_counter).insert 2, "GSK PIN"
     list_sheet.row(row_counter).insert 3, "Cust Name"
     list_sheet.row(row_counter).insert 4, "Contact No"
     list_sheet.row(row_counter).insert 5, "Alt Contact No"
     list_sheet.row(row_counter).insert 6, "Address"
     list_sheet.row(row_counter).insert 7, "State"
     list_sheet.row(row_counter).insert 8, "City"

     install_book.length.times do |idx|
       row_counter += 1 
       list_sheet.row(row_counter).insert 0, install_book[idx].Slip_Trans_id.to_s
       list_sheet.row(row_counter).insert 1, install_book[idx].GSK_No.to_i
       list_sheet.row(row_counter).insert 2, install_book[idx].GSK_Pin.to_i
       list_sheet.row(row_counter).insert 3, install_book[idx].cust_inf.CName
       list_sheet.row(row_counter).insert 4, install_book[idx].cust_inf.Contact_No.to_i
       list_sheet.row(row_counter).insert 5, install_book[idx].cust_inf.Alt_Con_No.nil? ? '' : install_book[idx].cust_inf.Alt_Con_No.to_i
       list_sheet.row(row_counter).insert 6, install_book[idx].cust_inf.Address
       list_sheet.row(row_counter).insert 7, install_book[idx].cust_inf.State
       list_sheet.row(row_counter).insert 8, install_book[idx].cust_inf.City
     end
  end

end
