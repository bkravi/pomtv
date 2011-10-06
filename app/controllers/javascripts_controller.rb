class JavascriptsController < ApplicationController
  def cust_infs
    @state_city_list = CustInf.find_by_sql("select State, City from statecity where state is not null and city is not null and state <> '' and city  <> '' order by state")
  end
end
