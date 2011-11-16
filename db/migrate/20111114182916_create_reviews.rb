class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :project
      t.integer :tipo
      t.text    :texto
      
      t.integer  :criou_user_id
      t.datetime :criou_at
      
      t.integer  :corrigiu_user_id
      t.datetime :corrigiu_at
      
      t.integer  :revisou_user_id
      t.datetime :revisou_at
      t.boolean  :revisou_aprovou

      t.timestamps
    end
    add_index :reviews, :project_id
  end
end
