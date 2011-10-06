class CreateInstallBooks < ActiveRecord::Migration
  def self.up
    create_table :install_books do |t|
      t.integer :cust_inf_id
      t.integer :CustId
      t.integer :GSK_No
      t.integer :GSK_Pin
      t.integer :RCV_No
      t.integer :RCV_Pin

      t.timestamps
    end
  end

  def self.down
    drop_table :install_books
  end
end
