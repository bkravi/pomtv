class InstallBook < ActiveRecord::Base
  belongs_to :cust_inf

  validates :CustId, :presence => true, :numericality => true
  validates :GSK_No, :presence => true, :length => 1..11, :numericality => true
  validates :GSK_Pin, :presence => true, :length => 1..11, :numericality => true
  validates :RCV_No, :presence => true, :length => 1..11, :numericality => true
  validates :RCV_Pin, :presence => true, :length => 1..11, :numericality => true
end
