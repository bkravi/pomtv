class InstallBooksController < ApplicationController
  before_filter :login_required
  #load_and_authorize_resource

  # GET /install_books
  def index
    @_nm = ''
    @_slp = ''
    @_gskno = ''
    @_gskpin = ''
    @_scn = ''
    @_rcvno = ''
    @_rcvpin = ''
    @_ins = "NO"
    @install_books = InstallBook.find(:all, :order => "cust_id desc", :conditions => ["delete_flag = 0 and NOT installed"]).paginate(:page => params[:page], :per_page => 100)
    #@install_books = InstallBook.find(:all, :order => "cust_id desc", :conditions => ["delete_flag = 0 and NOT installed"])
  end

  def show_sorted_install
    @_nm = params[:nm]
    @_slp= params[:slp]
    @_gskno= params[:gskno]
    @_gskpin= params[:gskpin]
    @_scn= params[:scn]
    @_rcvno= params[:rcvno]
    @_rcvpin= params[:rcvpin]
    if ! params[:is_installed_val].nil?
      @_ins = params[:is_installed_val]
    else
      @_ins = params[:is_installed].nil? ? "NO" : (params[:is_installed][:val].nil? ? "ALL" : params[:is_installed][:val])
    end
    cust_qry_array = ["select distinct cust_id from cust_infs where delete_flag = 0"]
    cust_qry_array << "upper(cname) like '#{@_nm.to_s.upcase}%'" if ! @_nm.blank?
    cust_qry = cust_qry_array.join(" and ")
    
    qry_array = ["select * from install_books where delete_flag = 0 and cust_id in (#{cust_qry})"]
    qry_array << "upper(slip_trans_id) like '#{@_slp.to_s.upcase}%'" if ! @_slp.blank?
    qry_array << "gsk_no like '#{@_gskno}%'" if ! @_gskno.blank?
    qry_array << "gsk_pin like '#{@_gskpin}%'" if ! @_gskpin.blank?
    qry_array << "smartcardno like '#{@_scn}%'" if ! @_scn.blank?
    qry_array << "rcv_no like '#{@_rcvno}%'" if ! @_rcvno.blank?
    qry_array << "rcv_pin like '#{@_rcvpin}%'" if ! @_rcvpin.blank?
    qry_array << "NOT installed" if @_ins == "NO"
    qry_array << "installed" if @_ins == "YES"
    qry = qry_array.join(" and ") + " order by cust_id desc "
    @install_books = InstallBook.find_by_sql(qry).paginate(:page => params[:page], :per_page => 100)
    #@install_books = InstallBook.find_by_sql(qry)
    render :action => "index"
    #render :text => qry_array
  end

  def edit_booking_fields
    flash[:notice] = nil
    @install_book = InstallBook.find(params[:edit_id])
  end

  def update_new_gsk
    @_nm = '' ; @_slp = '' ; @_gskno = '' ; @_gskpin = '' ; @_scn = '' ; @_rcvno = '' ; @_rcvpin = '' ; @_ins = "NO"
    new_gsk_no = params[:install_book][:gsk_no]
    new_gsk_pin = params[:install_book][:gsk_pin]
    new_rcv_no = params[:install_book][:rcv_no]
    new_rcv_pin = params[:install_book][:rcv_pin]
    new_smartcardno = params[:install_book][:smartcardno]
    new_remarks = params[:install_book][:remarks]
    if params[:update]
      #render :text => params[:install_book_id];return
      @temp_install_book = InstallBook.find(:first, :conditions => ["id = ?",params[:install_book_id]])
      @temp_cust_inf = CustInf.find(:first, :conditions => ["id = ?", @temp_install_book.cust_id])
      if @temp_install_book.nil? or @temp_cust_inf.nil?
        flash[:notice] = "#ERROR#Error in update!! Tables are not in sync !!"
      else
        @temp_install_book.gsk_no = new_gsk_no
        @temp_install_book.gsk_pin = new_gsk_pin
        if ! @temp_install_book.save
          @install_book = @temp_install_book
          render :action => "edit_booking_fields"
          return
        else
          flash[:notice] = "Workorder For Customer '#{@temp_cust_inf.cname}' Has Been Succefully Updated"
        end
      end
    end
    @install_books = InstallBook.find(:all, :order => "cust_id desc", :conditions => ["delete_flag = 0 and NOT installed"]).paginate(:page => params[:page], :per_page => 100)
    render :action => "index"
  end

  # GET /install_books/1
  def show
    @install_book = InstallBook.find(params[:id])
  end

  # GET /install_books/new
  def new
    @redirect_from_cust_infs_controller = !params[:cust_id_for_wo].nil? == true ? true : false 
    @install_book = InstallBook.new
    if @redirect_from_cust_infs_controller
      cust_list = CustInf.find(:first, :conditions => ["cust_id = ?", params[:cust_id_for_wo]])
      @booking_for = ["#{(cust_list.trans_id||cust_list.slip_no) + '=>' + cust_list.cust_id.to_s + '=>' + cust_list.cname + '=>' + cust_list.contact_no.to_s + '=>' + cust_list.city}"]
    else
      @booking_for = _fill_bookingfor_list
    end
  end

  # GET /install_books/1/edit
  def edit
    @install_book = InstallBook.find(params[:id])
  end

  # POST /install_books
  def create
    if params[:cancel_and_back_to_cust]
      redirect_to new_cust_inf_path
      return
    end
    @install_book = InstallBook.new(params[:install_book])
    @booking_for = _fill_bookingfor_list
    if params[:booking_for_cust][:cust] == "----Please select the customer----"
      flash[:notice] = "#ERROR# Kindly Select The Customer First"
      render :action => "new"
    else
      booking_for_list = params[:booking_for_cust][:cust].split("=>")
      booking_slip_or_transid = booking_for_list[0]
      booking_custid = booking_for_list[1]
      booking_custname = booking_for_list[2]
      booking_contactno = booking_for_list[3]
      booking_city = booking_for_list[4]
      if @install_book.save
        @install_book.update_attribute(:slip_trans_id, booking_slip_or_transid)
        @install_book.update_attribute(:cust_inf_id, booking_custid)
        @install_book.update_attribute(:cust_id, booking_custid)
        flash[:notice] = 'Workorder successfully created'
        if params[:save]
          redirect_to install_books_path
        elsif params[:save_and_back_to_cust]
          redirect_to new_cust_inf_path
        else
          redirect_to new_install_book_path
        end
      else
        if params[:save_and_back_to_cust]
          params[:cust_id_for_wo] = booking_custid
          @redirect_from_cust_infs_controller = true
          cust_list = CustInf.find(:first, :conditions => ["cust_id = ?", params[:cust_id_for_wo]])
          @booking_for = ["#{(cust_list.trans_id||cust_list.slip_no) + '=>' + cust_list.cust_id.to_s + '=>' + cust_list.cname + '=>' + cust_list.contact_no.to_s + '=>' + cust_list.city}"]
          render :action => "new"
        else
          render :action => "new"
        end
      end
    end
  end

  # PUT /install_books/1
  def update
    @install_book = InstallBook.find(params[:id])
    @install_book.smartcardno = params[:install_book][:smartcardno]
    @install_book.rcv_no = params[:install_book][:rcv_no]
    @install_book.rcv_pin = params[:install_book][:rcv_pin]
    @install_book.remarks = params[:install_book][:remarks]
    if params[:install_book][:smartcardno].nil? || params[:install_book][:smartcardno].blank? || params[:install_book][:rcv_no].nil? || params[:install_book][:rcv_no].blank? || params[:install_book][:rcv_pin].nil? || params[:install_book][:rcv_pin].blank?
      flash[:notice] = "#ERROR#Neither of the Smart Card NO, RCV NO, RCV PIN can be blank"
      render :action => "edit"
    else
      if @install_book.update_attributes(params[:install_book])
        @install_book.update_attribute(:installed, 1)
        cust_inf = CustInf.find(:first, :conditions => ["slip_no = '#{@install_book.slip_trans_id}' or Trans_id = '#{@install_book.slip_trans_id}'"])
        cust_inf.update_attribute(:installed, 1)
        cust_inf.update_attribute(:smartcardno, @install_book.smartcardno)
        cust_inf.update_attribute(:remarks, @install_book.remarks)
        flash[:notice] = 'Recharge voucher successfully updated'
        redirect_to install_books_path
      else
        render :action => "edit"
      end
    end
  end

  # DELETE /install_books/1
  def destroy
    @install_book = InstallBook.find(params[:id])
    ## @install_book.destroy  ## We are not going to use delete intall_books records direct from UI in this release. May be in future...
    redirect_to install_books_path
  end

  private

  def _fill_bookingfor_list
    booking_for = ["****No customer found for booking****"]
    @cust_list = CustInf.find_by_sql("select * from cust_infs where cust_id not in (select cust_id from install_books where gsk_no is not null and delete_flag = 0) and NOT installed and delete_flag = 0 order by cname")
    @cust_list.length.times do |idx|
      booking_for = ["----Please select the customer----"] if idx == 0
      tmp_str = "#{(@cust_list[idx].trans_id||@cust_list[idx].slip_no) + '=>' + @cust_list[idx].cust_id.to_s + '=>' + @cust_list[idx].cname + '=>' + @cust_list[idx].contact_no.to_s + '=>' + @cust_list[idx].city}"
      booking_for << tmp_str
    end
    return booking_for
  end
end
