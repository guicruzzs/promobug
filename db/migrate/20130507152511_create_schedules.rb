class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.references :interest
      t.references :offer

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
