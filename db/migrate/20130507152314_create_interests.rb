class CreateInterests < ActiveRecord::Migration
  def self.up
    create_table :interests do |t|
      t.references :agenda
      t.string :wanted
      t.string :unwanted
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :interests
  end
end
