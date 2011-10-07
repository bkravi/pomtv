class ChangeDatatypesToString < ActiveRecord::Migration
  def self.up
    change_column :install_books, :GSK_No, :string
    change_column :install_books, :GSK_Pin, :string
    change_column :install_books, :RCV_No, :string
    change_column :install_books, :RCV_Pin, :string
  end

  def self.down
  end
end
