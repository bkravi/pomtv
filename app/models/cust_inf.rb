class CustInf < ActiveRecord::Base
  has_many :install_books
  validates :Slip_No, :presence => true
  validates :CName, :presence => true
  validates :Contact_No, :presence => true, :numericality => true
  validates :Address, :presence => true
  validates :State, :presence => true
  validates :City, :presence => true
  validates :PinCode, :presence => true, :length => 6..6, :numericality => true
  validates :Date_of_reg, :presence => true
  validates :SmartcardNo, :presence => true
  validates :Amount, :presence => true
end
