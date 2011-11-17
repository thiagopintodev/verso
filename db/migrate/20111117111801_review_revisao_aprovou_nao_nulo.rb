class ReviewRevisaoAprovouNaoNulo < ActiveRecord::Migration
  def up
    change_column "reviews", "revisou_aprovou", :boolean, :default=>false
    Review.update_all({:revisou_aprovou=>false}, {:revisou_aprovou=>nil})
  end

  def down
    change_column "reviews", "revisou_aprovou", :boolean, :default=>nil
  end
end
