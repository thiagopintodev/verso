class CriaReviewsAPartirDoAntigoFormato < ActiveRecord::Migration
  def up
    Project.all.each do |p|
      if p.status_revisao_texto==1
        p.reviews.create :criou_user_id => p.user_id_revisao_texto,
                         :criou_at => Time.now,
                         :texto => "(erro anterior ao sistema de revisoes)",
                         :tipo => TIPO_TEXTO
      end
      if p.status_revisao_final==1
        p.reviews.create :criou_user_id => p.user_id_revisao_texto,
                         :criou_at => Time.now,
                         :texto => "(erro anterior ao sistema de revisoes)",
                         :tipo => TIPO_FLASH
      end
      
    end
    Project.update_all "status_revisao_audio=0", "status_revisao_audio>1"
    Project.update_all "status_revisao_audio=2", "status_revisao_audio=1"
  end

  def down
    Project.update_all "status_revisao_audio=1", "status_revisao_audio=2"
  end
end
