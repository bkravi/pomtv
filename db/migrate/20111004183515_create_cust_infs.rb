class CreateCustInfs < ActiveRecord::Migration
  def self.up
    create_table :cust_infs do |t|
      t.integer :CustId
      t.integer :Trans_id
      t.string :Slip_No
      t.string :CName
      t.string :Contact_No
      t.string :Alt_Con_No
      t.string :Address
      t.string :State
      t.string :City
      t.integer :PinCode
      t.date :Date_of_reg
      t.decimal :Amount, :precision=>8,:scale=>2,:default=>0
      t.string :SmartcardNo
      t.boolean :Installed
      t.string :Remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :cust_infs
  end
end
