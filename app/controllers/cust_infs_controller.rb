class CustInfsController < ApplicationController
  # GET /cust_infs
  def index
    @cust_infs = CustInf.find(:all, :order => "cname", :conditions => ["delete_flag = 0"]).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /cust_infs/1
  def show
    @cust_inf = CustInf.find(params[:id])
  end

  # GET /cust_infs/new
  def new
    @cust_inf = CustInf.new
    @states = CustInf.find_by_sql("select distinct state from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = ["----Select State----"]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].state
    end
  end

  # GET /cust_infs/1/edit
  def edit
    @cust_inf = CustInf.find(params[:id])
    @states = CustInf.find_by_sql("select distinct state from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = ["----Select State----"]
    @city_list = [""]
    @state = @cust_inf.state
    @city = @cust_inf.city
    @states.length.times do |index|
      @state_list << @states[index].state
    end
  end

  # POST /cust_infs
  def create
    @cust_inf = CustInf.new(params[:cust_inf])
    @cust_inf.cname.capitalize!
    @states = CustInf.find_by_sql("select distinct state from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = ["----Select State----"]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].state
    end
    params[:cust_inf][:slip_no]=nil if params[:cust_inf][:slip_no].blank? || params[:cust_inf][:slip_no].nil?
    params[:cust_inf][:trans_id]=nil if params[:cust_inf][:trans_id].blank? || params[:cust_inf][:trans_id].nil?
    if (((params[:cust_inf][:slip_no].blank? || params[:cust_inf][:slip_no].nil?) && (params[:cust_inf][:trans_id].blank? || params[:cust_inf][:trans_id].nil?)) || ((! params[:cust_inf][:slip_no].nil?) && (! params[:cust_inf][:trans_id].nil?)))
      flash[:notice] = "#ERROR#Please provide either Slip No. or Transaction ID"
      render :action => "new"
    else
      if @cust_inf.save
        @cust_inf.update_attribute(:cust_id, @cust_inf.id)
        flash[:notice] = 'Customer was successfully created'
        if params[:save]
          redirect_to cust_infs_path
        else
          redirect_to new_cust_inf_path
        end
      else
        render :action => "new"
      end
    end
  end

  # PUT /cust_infs/1
  def update
    @cust_inf = CustInf.find(params[:id])
    @states = CustInf.find_by_sql("select distinct state from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = ["----Select State----"]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].state
    end
    params[:cust_inf][:cname].capitalize! if (! params[:cust_inf][:cname].nil?)
    params[:cust_inf][:slip_no]=nil if params[:cust_inf][:slip_no].blank? || params[:cust_inf][:slip_no].nil?
    params[:cust_inf][:trans_id]=nil if params[:cust_inf][:trans_id].blank? || params[:cust_inf][:trans_id].nil?
    if (((params[:cust_inf][:slip_no].blank? || params[:cust_inf][:slip_no].nil?) && (params[:cust_inf][:trans_id].blank? || params[:cust_inf][:trans_id].nil?)) || ((! params[:cust_inf][:slip_no].nil?) && (! params[:cust_inf][:trans_id].nil?)))
      flash[:notice] = "#ERROR#Please provide either Slip No. or Transaction ID"
      render :action => "edit"
    else
      if @cust_inf.update_attributes(params[:cust_inf])
        flash[:notice] = "Customer was successfully updated"
        redirect_to cust_infs_path
      else
        render :action => "edit"
      end
    end
  end

  # DELETE /cust_infs/1
  def destroy
    @cust_inf = CustInf.find(params[:id])
    slip_or_trans_id = @cust_inf.slip_no || @cust_inf.Trans_id
    @install_book = InstallBook.find(:first, :conditions => ["slip_trans_id = ?", slip_or_trans_id])
    if ! @install_book.nil?
      ## @install_book.destroy
      @install_book.update_attribute(:delete_flag,1)  ## Soft delete
    end
    ## @cust_inf.destroy
    @cust_inf.update_attribute(:delete_flag,1)  ## Soft delete
    flash[:notice] = 'Customer was successfully deleted'
    redirect_to cust_infs_path
  end
end
