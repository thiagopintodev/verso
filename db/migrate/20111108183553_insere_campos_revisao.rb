class InsereCamposRevisao < ActiveRecord::Migration
  def change
    add_column :users, :is_revisao_texto, :boolean, :default => nil
    add_column :users, :is_revisao_final, :boolean, :default => nil
    
    add_column :projects, :status_revisao_texto,  :integer, :default => 0
    add_column :projects, :status_revisao_final,  :integer, :default => 0
    add_column :projects, :user_id_revisao_texto, :integer, :default => 0
    add_column :projects, :user_id_revisao_final, :integer, :default => 0
    
    add_column :project_versions, :status_revisao_texto,  :integer, :default => 0
    add_column :project_versions, :status_revisao_final,  :integer, :default => 0
    add_column :project_versions, :user_id_revisao_texto, :integer, :default => 0
    add_column :project_versions, :user_id_revisao_final, :integer, :default => 0
  end
end
