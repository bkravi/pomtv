class InstallBook < ActiveRecord::Base
  belongs_to :cust_inf

  before_create :set_default_values
  before_update :set_default_values
  
  def set_default_values
    self.rcv_no = (self.rcv_no.nil? || self.rcv_no.blank?) ? nil : self.rcv_no
    self.rcv_pin = (self.rcv_pin.nil? || self.rcv_pin.blank?) ? nil : self.rcv_pin
    self.slip_trans_id = (self.slip_trans_id.nil? || self.slip_trans_id.blank?) ? nil : self.slip_trans_id
    self.smartcardno = (self.smartcardno.nil? || self.smartcardno.blank?) ? nil : self.smartcardno
    self.remarks = (self.remarks.nil? || self.remarks.blank?) ? nil : self.remarks
    self.installed = (self.installed.nil? || self.installed.blank?) ? 0 : self.installed
  end

  def validate
    errors.add_to_base("RCV NO is not a number") if (rcv_no.to_i == 0 && !rcv_no.blank?)
    errors.add_to_base("RCV PIN is not a number") if (rcv_pin.to_i == 0 && !rcv_pin.blank?)
    errors.add_to_base("Smart Card# is not a number") if (smartcardno.to_i == 0 && !smartcardno.blank?)
  end

  validates :gsk_no, :presence => true, :length => 1..18, :numericality => true
  validates :gsk_pin, :presence => true, :length => 1..18, :numericality => true
end
