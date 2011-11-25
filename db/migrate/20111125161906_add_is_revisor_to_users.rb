class AddIsRevisorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_revisor, :boolean, :default=>false
  end
end
