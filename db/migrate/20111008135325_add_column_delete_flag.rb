class AddColumnDeleteFlag < ActiveRecord::Migration
  def self.up
    add_column :cust_infs, :delete_flag, :integer, :default => 0
    add_column :install_books, :delete_flag, :integer, :default => 0
  end

  def self.down
    remove_column :cust_infs, delete_flag
    remove_column :install_books, delete_flag
  end
end
