class RenameProjectSequenciaToNumero < ActiveRecord::Migration
  def change
    rename_column :projects, :sequencia, :numero
  end
end
