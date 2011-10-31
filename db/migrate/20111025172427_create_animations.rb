class CreateAnimations < ActiveRecord::Migration
  def self.up
    create_table :animations do |t|
      t.references :project
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :animations
  end
end
