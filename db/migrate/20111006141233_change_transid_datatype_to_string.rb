class ChangeTransidDatatypeToString < ActiveRecord::Migration
  def self.up
    change_column :cust_infs, :Trans_id, :string
  end

  def self.down
  end
end
