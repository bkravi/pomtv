class CreateSwamaanList < ActiveRecord::Migration
  def self.up
    create_table :swamaan_lists do |t|
      t.integer :SwamaanID, :default => nil
      t.string :Swamaan, :default => nil
      t.timestamps
    end
  end

  def self.down
    drop_table :swamaan_lists
  end
end
