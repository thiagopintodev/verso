class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.string :nome
      t.timestamps
    end
    (1..9).to_a.each { |nome| Degree.create! :nome => nome }
  end

  def self.down
    drop_table :degrees
  end
end
