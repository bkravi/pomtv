class InstallBooksController < ApplicationController
  # GET /install_books
  def index
    @install_books = InstallBook.find(:all, :order => "CustId", :conditions => ["delete_flag = 0"]).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /install_books/1
  def show
    @install_book = InstallBook.find(params[:id])
  end

  # GET /install_books/new
  def new
    @install_book = InstallBook.new
    @booking_for = _fill_bookingfor_list
  end

  # GET /install_books/1/edit
  def edit
    @install_book = InstallBook.find(params[:id])
  end

  # POST /install_books
  def create
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
        @install_book.update_attribute(:Slip_Trans_id, booking_slip_or_transid)
        @install_book.update_attribute(:cust_inf_id, booking_custid)
        @install_book.update_attribute(:CustId, booking_custid)
        flash[:notice] = 'Workorder successfully created'
        if params[:save]
          redirect_to install_books_path
        else
          redirect_to new_install_book_path
        end
      else
        render :action => "new"
      end
    end
  end

  # PUT /install_books/1
  def update
    @install_book = InstallBook.find(params[:id])
    @install_book.SmartcardNo = params[:install_book][:SmartcardNo]
    @install_book.RCV_No = params[:install_book][:RCV_No]
    @install_book.RCV_Pin = params[:install_book][:RCV_Pin]
    @install_book.Remarks = params[:install_book][:Remarks]
    if params[:install_book][:SmartcardNo].nil? || params[:install_book][:SmartcardNo].blank? || params[:install_book][:RCV_No].nil? || params[:install_book][:RCV_No].blank? || params[:install_book][:RCV_Pin].nil? || params[:install_book][:RCV_Pin].blank?
      flash[:notice] = "#ERROR#Neither of the Smartcard No, RCV Pin, RCV No can be blank"
      render :action => "edit"
    else
      if @install_book.update_attributes(params[:install_book])
        @install_book.update_attribute(:Installed, 1)
        cust_inf = CustInf.find(:first, :conditions => ["Slip_No = '#{@install_book.Slip_Trans_id}' or Trans_id = '#{@install_book.Slip_Trans_id}'"])
        cust_inf.update_attribute(:Installed, 1)
        cust_inf.update_attribute(:SmartcardNo, @install_book.SmartcardNo)
        cust_inf.update_attribute(:Remarks, @install_book.Remarks)
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
    booking_for = ["****No customer found to book****"]
    @cust_list = CustInf.find_by_sql("select * from cust_infs where CustId not in (select CustId from install_books where GSK_No is not null and delete_flag = 0) and NOT Installed and delete_flag = 0 order by CName")
    @cust_list.length.times do |idx|
      booking_for = ["----Please select the customer----"] if idx == 0
      tmp_str = "#{(@cust_list[idx].Trans_id||@cust_list[idx].Slip_No) + '=>' + @cust_list[idx].CustId.to_s + '=>' + @cust_list[idx].CName + '=>' + @cust_list[idx].Contact_No.to_s + '=>' + @cust_list[idx].City}"
      booking_for << tmp_str
    end
    return booking_for
  end
end
