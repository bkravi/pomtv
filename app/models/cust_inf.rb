class CustInf < ActiveRecord::Base

  before_create :set_default_values
  before_update :set_default_values
  
  def set_default_values
    self.trans_id = (self.trans_id.nil? || self.trans_id.blank?) ? nil : self.trans_id
    self.slip_no = (self.slip_no.nil? || self.slip_no.blank?) ? nil : self.slip_no
    self.alt_con_no = (self.alt_con_no.nil? || self.alt_con_no.blank?) ? nil : self.alt_con_no
    self.smartcardno = (self.smartcardno.nil? || self.smartcardno.blank?) ? nil : self.smartcardno  ## Will assign while booking
    self.remarks = (self.remarks.nil? || self.remarks.blank?) ? nil : self.remarks  ## Will assign while booking
    self.installed = (self.installed.nil? || self.installed.blank?) ? 0 : self.installed  ## Will assign when RCV is done
  end

  validates :cname, :presence => true
  validates :contact_no, :presence => true, :numericality => true
  validates :address, :presence => true
  validates :state, :presence => true
  validates :city, :presence => true
  validates :pincode, :presence => true, :length => 6..6, :numericality => true
  validates :date_of_reg, :presence => true
  validates :amount, :presence => true, :inclusion => (1000..30000)
end
