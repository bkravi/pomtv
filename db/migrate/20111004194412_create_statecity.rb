class CreateStatecity < ActiveRecord::Migration
  def self.up
    create_table :statecity do |t|
      t.string :State
      t.string :City

      t.timestamps
    end
   
  end

  def self.down
    drop_table :statecity
  end
end
