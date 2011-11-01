class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.references :subject
      t.references :degree
      t.integer :sequencia, :default=>1
      t.integer :project_versions_count, :default=>0
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
