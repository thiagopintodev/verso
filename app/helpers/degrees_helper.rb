module DegreesHelper

  def link_to_sumario(degree)
    link_to "sumario #{degree.to_s}", degree.arquivo.url, :target=>'_blank' if degree.arquivo?
  end
  
  def image_tag_sumario
    image_tag "http://aux4.iconpedia.net/uploads/730515789872400627.png", :width=>64
  end

end
