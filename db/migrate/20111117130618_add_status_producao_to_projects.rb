class AddStatusProducaoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :status_producao, :integer, :default=>0
  end
end
