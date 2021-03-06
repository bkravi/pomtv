class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :persistence_token, :string
  end

  def self.down
    remove_column :users, :email
    remove_column :users, :persistence_token
  end
end
