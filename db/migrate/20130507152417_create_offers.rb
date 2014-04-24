class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.string :twitter_message
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
