class AddRegexpToInterests < ActiveRecord::Migration
  def self.up
    change_table :interests do |t|
      t.string :wanted_regexp
      t.string :unwanted_regexp
    end
  end

  def self.down
    remove_column :interests, :wanted_regexp
    remove_column :interests, :unwanted_regexp
  end
end
