class AddAttachmentFlaSwf1Swf2Swf3Swf4ToProjectVersion < ActiveRecord::Migration
  def self.up
    add_column :project_versions, :fla_file_name, :string
    add_column :project_versions, :fla_content_type, :string
    add_column :project_versions, :fla_file_size, :integer
    add_column :project_versions, :fla_updated_at, :datetime
    add_column :project_versions, :swf1_file_name, :string
    add_column :project_versions, :swf1_content_type, :string
    add_column :project_versions, :swf1_file_size, :integer
    add_column :project_versions, :swf1_updated_at, :datetime
    add_column :project_versions, :swf2_file_name, :string
    add_column :project_versions, :swf2_content_type, :string
    add_column :project_versions, :swf2_file_size, :integer
    add_column :project_versions, :swf2_updated_at, :datetime
    add_column :project_versions, :swf3_file_name, :string
    add_column :project_versions, :swf3_content_type, :string
    add_column :project_versions, :swf3_file_size, :integer
    add_column :project_versions, :swf3_updated_at, :datetime
    add_column :project_versions, :swf4_file_name, :string
    add_column :project_versions, :swf4_content_type, :string
    add_column :project_versions, :swf4_file_size, :integer
    add_column :project_versions, :swf4_updated_at, :datetime
  end

  def self.down
    remove_column :project_versions, :fla_file_name
    remove_column :project_versions, :fla_content_type
    remove_column :project_versions, :fla_file_size
    remove_column :project_versions, :fla_updated_at
    remove_column :project_versions, :swf1_file_name
    remove_column :project_versions, :swf1_content_type
    remove_column :project_versions, :swf1_file_size
    remove_column :project_versions, :swf1_updated_at
    remove_column :project_versions, :swf2_file_name
    remove_column :project_versions, :swf2_content_type
    remove_column :project_versions, :swf2_file_size
    remove_column :project_versions, :swf2_updated_at
    remove_column :project_versions, :swf3_file_name
    remove_column :project_versions, :swf3_content_type
    remove_column :project_versions, :swf3_file_size
    remove_column :project_versions, :swf3_updated_at
    remove_column :project_versions, :swf4_file_name
    remove_column :project_versions, :swf4_content_type
    remove_column :project_versions, :swf4_file_size
    remove_column :project_versions, :swf4_updated_at
  end
end
