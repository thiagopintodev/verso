class AddAttachmentArquivoToDegree < ActiveRecord::Migration
  def self.up
    add_column :degrees, :arquivo_file_name, :string
    add_column :degrees, :arquivo_content_type, :string
    add_column :degrees, :arquivo_file_size, :integer
    add_column :degrees, :arquivo_updated_at, :datetime
  end

  def self.down
    remove_column :degrees, :arquivo_file_name
    remove_column :degrees, :arquivo_content_type
    remove_column :degrees, :arquivo_file_size
    remove_column :degrees, :arquivo_updated_at
  end
end
