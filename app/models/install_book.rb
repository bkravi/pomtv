class InstallBook < ActiveRecord::Base
  belongs_to :cust_inf

  before_create :set_default_values
  before_update :set_default_values
  
  def set_default_values
    self.RCV_No = (self.RCV_No.nil? || self.RCV_No.blank?) ? nil : self.RCV_No
    self.RCV_Pin = (self.RCV_Pin.nil? || self.RCV_Pin.blank?) ? nil : self.RCV_Pin
    self.Slip_Trans_id = (self.Slip_Trans_id.nil? || self.Slip_Trans_id.blank?) ? nil : self.Slip_Trans_id
    self.SmartcardNo = (self.SmartcardNo.nil? || self.SmartcardNo.blank?) ? nil : self.SmartcardNo
    self.Remarks = (self.Remarks.nil? || self.Remarks.blank?) ? nil : self.Remarks
    self.Installed = (self.Installed.nil? || self.Installed.blank?) ? 0 : self.Installed
  end

  validates :GSK_No, :presence => true, :length => 1..18, :numericality => true
  validates :GSK_Pin, :presence => true, :length => 1..18, :numericality => true
end
