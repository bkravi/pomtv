class CustInfsController < ApplicationController
  # GET /cust_infs
  def index
    sort = "cname"
    @_nm = ''
    @_add = ''
    @_cont = ''
    @_st= ''
    @_ins = "NO"
    @sort_on = ["Id: Asc","Id: Desc","Name: Asc","Name: Desc","Address: Asc", "Address: Desc", "State: Asc","State: Desc","City: Asc","City: Desc","Reg Date: Asc","Reg Date: Desc","SCN: Asc","SCN: Desc","Installed: Asc","Installed: Desc" ]
    @cust_infs = CustInf.find(:all, :conditions => ["delete_flag = 0 and not installed"]).paginate :page => params[:page], :per_page => 100, :order => "#{sort}"
  end

  def show_sorted
    ## For the time being not implementing sorting. By default: cname asc
    #tmp = params[:sort_by].nil? ? "cname" : (params[:sort_by][:val].nil? ? "cname" : params[:sort_by][:val])
    tmp = "Name: Asc"
    @_ins = params[:is_installed].nil? ? "NO" : (params[:is_installed][:val].nil? ? "ALL" : params[:is_installed][:val])
    sort = case tmp
           when "Id: Asc"  then "id"
           when "Id: Desc"     then "id desc"
           when "Name: Asc" then "cname"
           when "Name: Desc"  then "cname desc"
           when "Address: Asc"       then "address"
           when "Address: Desc"       then "address desc"
           when "State: Asc"       then "state"
           when "State: Desc"      then "state desc"
           when "City: Asc"      then "city"
           when "City: Desc"      then "city desc"
           when "Reg Date: Asc"      then "date_of_reg"
           when "Reg Date: Desc"      then "date_of_reg desc"
           when "SCN: Asc"      then "smartcardno"
           when "SCN: Desc"      then "smartcardno desc"
           when "Installed: Asc"      then "installed"
           when "Installed: Desc"      then "installed desc"
           else "cname"
           end
    @sort_on = ["Id: Asc","Id: Desc","Name: Asc","Name: Desc","Address: Asc", "Address: Desc", "State: Asc","State: Desc","City: Asc","City: Desc","Reg Date: Asc","Reg Date: Desc","SCN: Asc","SCN: Desc","Installed: Asc","Installed: Desc" ]
    @_nm = params[:nm]
    @_add = params[:add]
    @_cont = params[:cont]
    @_st= params[:st]
    qry_array = ["select * from cust_infs where delete_flag = 0"]
    qry_array << "upper(cname) like '#{@_nm.to_s.upcase}%'" if ! @_nm.blank?
    qry_array << "upper(address) like '#{@_add.to_s.upcase}%'" if ! @_add.blank?
    qry_array << "contact_no like '#{@_cont}%'" if ! @_cont.blank?
    qry_array << "upper(state) like '#{@_st.to_s.upcase}%'" if ! @_st.blank?
    qry_array << "NOT installed" if @_ins == "NO"
    qry_array << "installed" if @_ins == "YES"
    qry = qry_array.join(" and ") + " order by #{sort} "
    @cust_infs = CustInf.find_by_sql(qry).paginate :page => params[:page], :per_page => 100, :order => "#{sort}"
    render :action => "index"
    #render :text => qry
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
