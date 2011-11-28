class AddStatusRevisaoMetodoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status_revisao_metodo, :integer, :default=>0
  end
end
