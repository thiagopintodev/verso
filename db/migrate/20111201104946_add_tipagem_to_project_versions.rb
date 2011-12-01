class AddTipagemToProjectVersions < ActiveRecord::Migration
  def change
    add_column :project_versions, :tipo, :integer,      :default=>0
    add_column :project_versions, :sequencia, :integer, :default=>false
  end
end
