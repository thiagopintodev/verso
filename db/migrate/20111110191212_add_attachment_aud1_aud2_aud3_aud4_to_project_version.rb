class AddAttachmentAud1Aud2Aud3Aud4ToProjectVersion < ActiveRecord::Migration
  def self.up
    add_column :project_versions, :aud1_file_name, :string
    add_column :project_versions, :aud1_content_type, :string
    add_column :project_versions, :aud1_file_size, :integer
    add_column :project_versions, :aud1_updated_at, :datetime
    add_column :project_versions, :aud2_file_name, :string
    add_column :project_versions, :aud2_content_type, :string
    add_column :project_versions, :aud2_file_size, :integer
    add_column :project_versions, :aud2_updated_at, :datetime
    add_column :project_versions, :aud3_file_name, :string
    add_column :project_versions, :aud3_content_type, :string
    add_column :project_versions, :aud3_file_size, :integer
    add_column :project_versions, :aud3_updated_at, :datetime
    add_column :project_versions, :aud4_file_name, :string
    add_column :project_versions, :aud4_content_type, :string
    add_column :project_versions, :aud4_file_size, :integer
    add_column :project_versions, :aud4_updated_at, :datetime
  end

  def self.down
    remove_column :project_versions, :aud1_file_name
    remove_column :project_versions, :aud1_content_type
    remove_column :project_versions, :aud1_file_size
    remove_column :project_versions, :aud1_updated_at
    remove_column :project_versions, :aud2_file_name
    remove_column :project_versions, :aud2_content_type
    remove_column :project_versions, :aud2_file_size
    remove_column :project_versions, :aud2_updated_at
    remove_column :project_versions, :aud3_file_name
    remove_column :project_versions, :aud3_content_type
    remove_column :project_versions, :aud3_file_size
    remove_column :project_versions, :aud3_updated_at
    remove_column :project_versions, :aud4_file_name
    remove_column :project_versions, :aud4_content_type
    remove_column :project_versions, :aud4_file_size
    remove_column :project_versions, :aud4_updated_at
  end
end
