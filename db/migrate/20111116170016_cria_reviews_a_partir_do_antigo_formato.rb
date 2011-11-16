class CriaReviewsAPartirDoAntigoFormato < ActiveRecord::Migration
  def up
    Project.all.each do |p|
      if p.status_revisao_texto==Project::REVISAO_REJEITADO
        p.reviews.create :criou_user_id => p.user_id_revisao_texto,
                         :criou_at => Time.now,
                         :texto => "(erro cadastrado antes do sistema de revisoes)",
                         :tipo => Review::TIPO_TEXTO
      end
      if p.status_revisao_final==Project::REVISAO_REJEITADO
        p.reviews.create :criou_user_id => p.user_id_revisao_final,
                         :criou_at => Time.now,
                         :texto => "(erro cadastrado antes do sistema de revisoes)",
                         :tipo => Review::TIPO_FLASH
      end
    end
    
    Project.update_all "status_revisao_audio=0", "status_revisao_audio>1"
    Project.update_all "status_revisao_audio=2", "status_revisao_audio=1"
  end

  def down
    Project.update_all "status_revisao_audio=1", "status_revisao_audio=2"
  end
end
