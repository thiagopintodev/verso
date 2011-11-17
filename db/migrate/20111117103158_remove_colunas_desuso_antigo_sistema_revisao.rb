class RemoveColunasDesusoAntigoSistemaRevisao < ActiveRecord::Migration
  def change
    remove_column :project_versions, "status_revisao_texto"
    remove_column :project_versions, "status_revisao_final"
    remove_column :project_versions, "status_revisao_audio"
    remove_column :project_versions, "user_id_revisao_texto"
    remove_column :project_versions, "user_id_revisao_final"
    remove_column :project_versions, "user_id_revisao_audio"
    
    remove_column :projects, "user_id_revisao_texto"
    remove_column :projects, "user_id_revisao_final"
    remove_column :projects, "user_id_revisao_audio"
    
    remove_column :users, "is_revisao_texto"
    remove_column :users, "is_revisao_final"
    remove_column :users, "is_revisao_audio"
  end
end
