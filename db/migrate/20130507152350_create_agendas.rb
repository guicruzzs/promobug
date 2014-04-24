class CreateAgendas < ActiveRecord::Migration
  def self.up
    create_table :agendas do |t|
      t.references :user
      t.string :google_code
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :agendas
  end
end
