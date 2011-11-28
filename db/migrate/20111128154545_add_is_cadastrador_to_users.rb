class AddIsCadastradorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_cadastrador, :boolean, :default=>false
  end
end
