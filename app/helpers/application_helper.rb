module ApplicationHelper
  def month_no_of val
    return case val
             when "January" then 1
             when "February" then 2
             when "March" then 3
             when "April" then 4
             when "May" then 5
             when "June" then 6
             when "July" then 7
             when "August" then 8
             when "September" then 9
             when "October" then 10
             when "November" then 11
             when "December" then 12
             else -1
           end
  end
end
