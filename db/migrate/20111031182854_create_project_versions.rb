class CreateProjectVersions < ActiveRecord::Migration
  def change
    create_table :project_versions do |t|
      t.references :project
      t.references :user
      t.text :texto

      t.timestamps
    end
    add_index :project_versions, :project_id
    add_index :project_versions, :user_id
  end
end
