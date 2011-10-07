class AddColumnsToInstallBooks < ActiveRecord::Migration
  def self.up
    add_column :install_books, :Slip_Trans_id, :string
    add_column :install_books, :SmartcardNo, :string
    add_column :install_books, :Installed, :boolean
    add_column :install_books, :Remarks, :string
  end

  def self.down
    remove_column :install_books, :Slip_Trans_id
    remove_column :install_books, :SmartcardNo
    remove_column :install_books, :Installed
    remove_column :install_books, :Remarks
  end
end
