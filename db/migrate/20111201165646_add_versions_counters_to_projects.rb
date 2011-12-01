class AddVersionsCountersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_animations_count, :integer, :default => 0
    add_column :projects, :project_resources_count,  :integer, :default => 0
    remove_column :projects, :project_versions_count
  end
end
