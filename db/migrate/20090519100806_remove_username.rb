class RemoveUsername < ActiveRecord::Migration
  def self.up
    remove_column :users, :username
  end

  def self.down
  end
end
