require 'spreadsheet'
class UtilitiesController < ApplicationController
  before_filter :login_required

  def send_to_reliance
    #@utilities = @install_book = InstallBook.find(:all, :order => "slip_trans_id", :conditions => ["delete_flag = 0 and NOT installed"]).paginate(:page => params[:page], :per_page => 100)
    @utilities = @install_book = InstallBook.find(:all, :order => "slip_trans_id", :conditions => ["delete_flag = 0 and NOT installed"])
    render :layout => "reportlayout"
  end

  def save_reliance
    install_book = InstallBook.find(:all, :order => "slip_trans_id", :conditions => ["delete_flag = 0 and NOT installed"])
    
    list_name = "#{Time.now.to_s.gsub(/[: +]/,'_')}_WorkorderList.xls"
    list_book = Spreadsheet::Workbook.new
    list_sheet = list_book.create_worksheet(:name => "Workorder Details")

    _write_excel(list_sheet, install_book)   

    ## list_book.write "#{RAILS_ROOT}/public/downloads/#{list_name}"
    ## list_path = "#{RAILS_ROOT}/public/downloads/#{list_name}"
     list_book.write "#{RAILS_ROOT}/tmp/#{list_name}"
     list_path = "#{RAILS_ROOT}/tmp/#{list_name}"
    send_file list_path, :type => 'application/vnd.ms-excel'
  end

  def monthly_report
    qry = "select * from install_books RIGHT OUTER JOIN cust_infs ON(cust_infs.cust_id=install_books.cust_id) where cust_infs.delete_flag=0 and (install_books.delete_flag=0 OR install_books.delete_flag is NULL)"
    @_mon = params[:mon].nil? ? "#{Time.now.strftime('%B')}" : (params[:mon][:val].nil? ? "#{Time.now.strftime('%B')}" : params[:mon][:val])
    @_ins = params[:ins].nil? ? "NO" : (params[:ins][:val].nil? ? "NO" : params[:ins][:val])
    qry << " and cust_infs.installed " if @_ins == "YES"
    qry << " and not cust_infs.installed " if @_ins == "NO"
    qry << " and EXTRACT(MONTH from date_of_reg) = #{month_no_of(@_mon)} "
    qry += " order by date_of_reg "
    @final_query = qry
    #@utilities = @rec = CustInf.find_by_sql(qry).paginate(:page => params[:page], :per_page => 100)
    @utilities = @rec = CustInf.find_by_sql(qry)
    render :layout => "reportlayout"
    #render :text => qry
  end

  def daterange_report
    flash[:notice] = nil
    qry = "select * from install_books RIGHT OUTER JOIN cust_infs ON(cust_infs.cust_id=install_books.cust_id) where cust_infs.delete_flag=0 and (install_books.delete_flag=0 OR install_books.delete_flag is NULL)"
    @_st_dt = (params[:st_dt].nil? || params[:st_dt].blank?) ? (Time.now-5*24*60*60).strftime('%Y/%m/%d') : params[:st_dt]
    @_end_dt = (params[:end_dt].nil? || params[:end_dt].blank?) ? Time.now.strftime('%Y/%m/%d') : params[:end_dt]
    @_ins = params[:ins].nil? ? "NO" : (params[:ins][:val].nil? ? "NO" : params[:ins][:val])
    qry << " and date_of_reg between '#{@_st_dt}' and '#{@_end_dt}' "
    qry << " and cust_infs.installed " if @_ins == "YES"
    qry << " and not cust_infs.installed " if @_ins == "NO"
    qry += " order by date_of_reg "
    @final_query = qry
    #@utilities = @rec = CustInf.find_by_sql(qry).paginate(:page => params[:page], :per_page => 100)
    @utilities = @rec = CustInf.find_by_sql(qry)
    ## Check the validity of start/end dates
    if @_st_dt > @_end_dt
      flash[:notice] = "Start > End"
    end
    render :layout => "reportlayout"
  end

  def save_report
    rec = CustInf.find_by_sql(params[:qry])
    list_book = Spreadsheet::Workbook.new
    if ! params[:hidden_month].nil?
      _mon = params[:hidden_month]
      list_name = "#{Time.now.to_s.gsub(/[: +]/,'_')}_#{_mon}.xls"
      list_sheet = list_book.create_worksheet(:name => "#{_mon} Month Details")
    elsif (! params[:hidden_st].nil?) && (! params[:hidden_end].nil?)
      list_name = "#{Time.now.to_s.gsub(/[: +]/,'_')}_DATERANGE.xls"
      list_sheet = list_book.create_worksheet(:name => "DATERANGE Details")
    end
    
    _write_report_excel(list_sheet, rec)   

    ## list_book.write "#{RAILS_ROOT}/public/downloads/#{list_name}"
    ## list_path = "#{RAILS_ROOT}/public/downloads/#{list_name}"
     list_book.write "#{RAILS_ROOT}/tmp/#{list_name}"
     list_path = "#{RAILS_ROOT}/tmp/#{list_name}"
    send_file list_path, :type => 'application/vnd.ms-excel'
    #render :text => params[:qry] + "  " + (params[:hidden_st]||"") + "  " + (params[:hidden_end]||"") + "  " + (params[:hidden_month]||"")
  end

  private
  def _write_report_excel(list_sheet, rec)
     row_counter = 0
     list_sheet.row(row_counter).default_format = Spreadsheet::Format.new(:weight=>"bold",:color=>"white",:pattern  => 1,:pattern_fg_color => "blue")
     list_sheet.row(row_counter).insert 0, "ID"
     list_sheet.row(row_counter).insert 1, "Cust Name"
     list_sheet.row(row_counter).insert 2, "Contact#"
     list_sheet.row(row_counter).insert 3, "Alt Cont#"
     list_sheet.row(row_counter).insert 4, "Address"
     list_sheet.row(row_counter).insert 5, "State"
     list_sheet.row(row_counter).insert 6, "City"
     list_sheet.row(row_counter).insert 7, "Slip/Trans ID"
     list_sheet.row(row_counter).insert 8, "Reg. Date"
     list_sheet.row(row_counter).insert 9, "GSK NO"
     list_sheet.row(row_counter).insert 10, "GSK PIN"
     list_sheet.row(row_counter).insert 11, "SmartCardNo"
     list_sheet.row(row_counter).insert 12, "RCV NO"
     list_sheet.row(row_counter).insert 13, "RCV PIN"
     list_sheet.row(row_counter).insert 14, "Installed"
     list_sheet.row(row_counter).insert 15, "Remarks"

     rec.length.times do |idx|
       row_counter += 1 
       list_sheet.row(row_counter).insert 0, rec[idx].cust_id
       list_sheet.row(row_counter).insert 1, rec[idx].cname
       list_sheet.row(row_counter).insert 2, rec[idx].contact_no.to_i
       list_sheet.row(row_counter).insert 3, (rec[idx].alt_con_no.nil? || rec[idx].alt_con_no.blank?) ?  "N/A" : rec[idx].alt_con_no.to_i
       list_sheet.row(row_counter).insert 4, rec[idx].address
       list_sheet.row(row_counter).insert 5, rec[idx].state
       list_sheet.row(row_counter).insert 6, rec[idx].city
       list_sheet.row(row_counter).insert 7, rec[idx].slip_trans_id
       list_sheet.row(row_counter).insert 8, rec[idx].date_of_reg
       list_sheet.row(row_counter).insert 9, (rec[idx].gsk_no.nil? || rec[idx].gsk_no.blank?) ? "N/A" : rec[idx].gsk_no
       list_sheet.row(row_counter).insert 10, (rec[idx].gsk_pin.nil? || rec[idx].gsk_pin.blank?) ? "N/A" : rec[idx].gsk_pin
       list_sheet.row(row_counter).insert 11, (rec[idx].smartcardno.nil? || rec[idx].smartcardno.blank?) ? "N/A" : rec[idx].smartcardno
       list_sheet.row(row_counter).insert 12, (rec[idx].rcv_no.nil? || rec[idx].rcv_no.blank?) ? "N/A" : rec[idx].rcv_no
       list_sheet.row(row_counter).insert 13, (rec[idx].rcv_pin.nil? || rec[idx].rcv_pin.blank?) ? "N/A" : rec[idx].rcv_pin
       list_sheet.row(row_counter).insert 14, rec[idx].installed? ? "YES" : "NO"
       list_sheet.row(row_counter).insert 15, (rec[idx].remarks.nil? || rec[idx].remarks.blank?) ?  "N/A" : rec[idx].remarks
     end
  end

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
       list_sheet.row(row_counter).insert 0, install_book[idx].slip_trans_id.to_s
       list_sheet.row(row_counter).insert 1, install_book[idx].gsk_no.to_s
       list_sheet.row(row_counter).insert 2, install_book[idx].gsk_pin.to_s
       list_sheet.row(row_counter).insert 3, install_book[idx].cust_inf.cname
       list_sheet.row(row_counter).insert 4, install_book[idx].cust_inf.contact_no.to_s
       list_sheet.row(row_counter).insert 5, install_book[idx].cust_inf.alt_con_no.nil? ? '' : install_book[idx].cust_inf.alt_con_no.to_s
       list_sheet.row(row_counter).insert 6, install_book[idx].cust_inf.address
       list_sheet.row(row_counter).insert 7, install_book[idx].cust_inf.state
       list_sheet.row(row_counter).insert 8, install_book[idx].cust_inf.city
     end
  end

end
