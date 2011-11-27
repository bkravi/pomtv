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
    if !rcv_no.blank?
      errors.add_to_base("RCV NO must be a 12 digit number") if (rcv_no.length != 12 or rcv_no.to_i.to_s.length != 12)
    end
    if !rcv_pin.blank?
      errors.add_to_base("RCV PIN must be a 12 digit number") if (rcv_pin.length != 12 or rcv_pin.to_i.to_s.length != 12)
    end
    if !smartcardno.blank?
      errors.add_to_base("Smart Card# must be a 12 digit number") if (smartcardno.length != 12 or smartcardno.to_i.to_s.length != 12)
    end
    errors.add_to_base("GSK NO must be a 14 digit number") if (gsk_no.length != 14 or gsk_no.to_i.to_s.length != 14)
    errors.add_to_base("GSK PIN must be a 4 digit number") if (gsk_pin.length != 4 or gsk_pin.to_i.to_s.length != 4)
  end

end
