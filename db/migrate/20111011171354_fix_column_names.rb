class FixColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :cust_infs, :CustId, :cust_id
    rename_column :cust_infs, :Trans_id, :trans_id
    rename_column :cust_infs, :Slip_No, :slip_no
    rename_column :cust_infs, :CName, :cname
    rename_column :cust_infs, :Contact_No, :contact_no
    rename_column :cust_infs, :Alt_Con_No, :alt_con_no
    rename_column :cust_infs, :Address, :address
    rename_column :cust_infs, :State, :state
    rename_column :cust_infs, :City, :city
    rename_column :cust_infs, :PinCode, :pincode
    rename_column :cust_infs, :Date_of_reg, :date_of_reg
    rename_column :cust_infs, :Amount, :amount
    rename_column :cust_infs, :SmartcardNo, :smartcardno
    rename_column :cust_infs, :Installed, :installed
    rename_column :cust_infs, :Remarks, :remarks

    rename_column :install_books, :CustId, :cust_id
    rename_column :install_books, :GSK_No, :gsk_no
    rename_column :install_books, :GSK_Pin, :gsk_pin
    rename_column :install_books, :RCV_No, :rcv_no
    rename_column :install_books, :RCV_Pin, :rcv_pin
    rename_column :install_books, :Slip_Trans_id, :slip_trans_id
    rename_column :install_books, :SmartcardNo, :smartcardno
    rename_column :install_books, :Installed, :installed
    rename_column :install_books, :Remarks, :remarks
                
    rename_column :statecity, :State, :state
    rename_column :statecity, :City, :city

    rename_column :swamaan_lists, :SwamaanID, :swamaan_id
    rename_column :swamaan_lists, :Swamaan, :swamaan

  end

  def self.down
  end
end
