class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.string :nome
      t.timestamps
    end
  end

  def self.down
    drop_table :degrees
  end
end
