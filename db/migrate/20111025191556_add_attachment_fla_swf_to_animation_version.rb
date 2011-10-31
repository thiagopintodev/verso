class AddAttachmentFlaSwfToAnimationVersion < ActiveRecord::Migration
  def self.up
    add_column :animation_versions, :fla_file_name, :string
    add_column :animation_versions, :fla_content_type, :string
    add_column :animation_versions, :fla_file_size, :integer
    add_column :animation_versions, :fla_updated_at, :datetime
    add_column :animation_versions, :swf_file_name, :string
    add_column :animation_versions, :swf_content_type, :string
    add_column :animation_versions, :swf_file_size, :integer
    add_column :animation_versions, :swf_updated_at, :datetime
  end

  def self.down
    remove_column :animation_versions, :fla_file_name
    remove_column :animation_versions, :fla_content_type
    remove_column :animation_versions, :fla_file_size
    remove_column :animation_versions, :fla_updated_at
    remove_column :animation_versions, :swf_file_name
    remove_column :animation_versions, :swf_content_type
    remove_column :animation_versions, :swf_file_size
    remove_column :animation_versions, :swf_updated_at
  end
end
