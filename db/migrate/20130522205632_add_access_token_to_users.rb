class AddAccessTokenToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :code_token
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_token_time
      t.integer :expires_in
    end
  end

  def self.down
    remove_column :users, :code_token
    remove_column :users, :access_token
    remove_column :users, :refresh_token
    remove_column :users, :access_token_time
    remove_column :users, :expires_in
  end
end