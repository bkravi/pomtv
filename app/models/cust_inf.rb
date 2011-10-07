class CustInf < ActiveRecord::Base

  before_create :set_default_values
  before_update :set_default_values
  
  def set_default_values
    self.Trans_id = (self.Trans_id.nil? || self.Trans_id.blank?) ? nil : self.Trans_id
    self.Slip_No = (self.Slip_No.nil? || self.Slip_No.blank?) ? nil : self.Slip_No
    self.Alt_Con_No = (self.Alt_Con_No.nil? || self.Alt_Con_No.blank?) ? nil : self.Alt_Con_No
    self.SmartcardNo = (self.SmartcardNo.nil? || self.SmartcardNo.blank?) ? nil : self.SmartcardNo
    self.Remarks = (self.Remarks.nil? || self.Remarks.blank?) ? nil : self.Remarks
  end

  validates :CName, :presence => true
  validates :Contact_No, :presence => true, :numericality => true
  validates :Address, :presence => true
  validates :State, :presence => true
  validates :City, :presence => true
  validates :PinCode, :presence => true, :length => 6..6, :numericality => true
  validates :Date_of_reg, :presence => true
  validates :Amount, :presence => true, :inclusion => (1000..30000)
end
