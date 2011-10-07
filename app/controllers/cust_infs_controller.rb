class CustInfsController < ApplicationController
  # GET /cust_infs
  def index
    @cust_infs = CustInf.all(:order => "CName")
  end

  # GET /cust_infs/1
  def show
    @cust_inf = CustInf.find(params[:id])
  end

  # GET /cust_infs/new
  def new
    @cust_inf = CustInf.new
    @states = CustInf.find_by_sql("select distinct State from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = [""]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].State
    end
  end

  # GET /cust_infs/1/edit
  def edit
    @cust_inf = CustInf.find(params[:id])
    @states = CustInf.find_by_sql("select distinct State from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = [""]
    @city_list = [""]
    @state = @cust_inf.State
    @city = @cust_inf.City
    @states.length.times do |index|
      @state_list << @states[index].State
    end
  end

  # POST /cust_infs
  def create
    @cust_inf = CustInf.new(params[:cust_inf])
    @cust_inf.CName.capitalize!
    @states = CustInf.find_by_sql("select distinct State from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = [""]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].State
    end
    params[:cust_inf][:Slip_No]=nil if params[:cust_inf][:Slip_No].blank? || params[:cust_inf][:Slip_No].nil?
    params[:cust_inf][:Trans_id]=nil if params[:cust_inf][:Trans_id].blank? || params[:cust_inf][:Trans_id].nil?
    if (((params[:cust_inf][:Slip_No].blank? || params[:cust_inf][:Slip_No].nil?) && (params[:cust_inf][:Trans_id].blank? || params[:cust_inf][:Trans_id].nil?)) || ((! params[:cust_inf][:Slip_No].nil?) && (! params[:cust_inf][:Trans_id].nil?)))
      flash[:notice] = "#ERROR#Please provide either Slip No. or Transaction ID"
      render :action => "new"
    else
      if @cust_inf.save
        @cust_inf.update_attribute(:CustId, @cust_inf.id)
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
    @states = CustInf.find_by_sql("select distinct State from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @state_list = [""]
    @city_list = [""]
    @states.length.times do |index|
      @state_list << @states[index].State
    end
    params[:cust_inf][:CName].capitalize! if (! params[:cust_inf][:CName].nil?)
    params[:cust_inf][:Slip_No]=nil if params[:cust_inf][:Slip_No].blank? || params[:cust_inf][:Slip_No].nil?
    params[:cust_inf][:Trans_id]=nil if params[:cust_inf][:Trans_id].blank? || params[:cust_inf][:Trans_id].nil?
    if (((params[:cust_inf][:Slip_No].blank? || params[:cust_inf][:Slip_No].nil?) && (params[:cust_inf][:Trans_id].blank? || params[:cust_inf][:Trans_id].nil?)) || ((! params[:cust_inf][:Slip_No].nil?) && (! params[:cust_inf][:Trans_id].nil?)))
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
    @cust_inf.destroy
    flash[:notice] = 'Customer was successfully deleted'
    redirect_to cust_infs_path
  end
end
