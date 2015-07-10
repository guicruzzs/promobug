class AddUserIdToInterests < ActiveRecord::Migration
  def self.up
    change_table :interests do |t|
      t.references :user
    end
  end

  def self.down
    remove_column :interests, :user_id
  end
end
