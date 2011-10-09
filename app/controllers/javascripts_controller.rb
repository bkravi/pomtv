class JavascriptsController < ApplicationController
  def cust_infs
    @state_city_list = CustInf.find_by_sql("select State, City from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
    @curr_year = Time.now.year
    @curr_month = Time.now.month
    @curr_day = Time.now.day
  end
end
