class CreateAnimationVersions < ActiveRecord::Migration
  def self.up
    create_table :animation_versions do |t|
      t.references :animation
      t.references :user
      t.text :texto
      t.timestamps
    end
  end

  def self.down
    drop_table :animation_versions
  end
end
