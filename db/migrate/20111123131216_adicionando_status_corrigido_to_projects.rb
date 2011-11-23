class AdicionandoStatusCorrigidoToProjects < ActiveRecord::Migration
  def up
    add_column :reviews, :status, :integer, :default => 0
    Project.all.map do |p|
      #se revisao_audio aprovada mas nao existem revisoes cadastradas
      #(precisa usar numero magico pois foi adicionado um status)
      if p.status_revisao_audio == 2 && p.reviews.audios.count.zero?
        Review.new.cadastrar_aprovada(User.find_auto, p.id, Review::TIPO_AUDIO)
      end
      if p.status_revisao_texto == 2 && p.reviews.textos.count.zero?
        Review.new.cadastrar_aprovada(User.find_auto, p.id, Review::TIPO_TEXTO)
      end
      if p.status_revisao_final == 2 && p.reviews.flashes.count.zero?
        Review.new.cadastrar_aprovada(User.find_auto, p.id, Review::TIPO_FLASH)
      end
    end
    Review.all.map &:save
    Project.all.map &:save
  end

  def down
    remove_column :reviews, :status, :integer
    Review.all.map &:save
    Project.all.map &:save  
  end
end
