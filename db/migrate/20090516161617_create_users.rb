class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string "email"
      t.string "crypted_password"
      t.string "password_salt"
      t.string "persistence_token"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string "perishable_token", :default => "", :null => false
      t.boolean "active", :default => false, :null => false
    end
  end

  def self.down
    drop_table :users
  end
end
