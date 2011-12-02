module DegreesHelper

  def link_to_sumario(degree)
    link_to "sumario #{degree.to_s}", degree.arquivo.url, :target=>'_blank' if degree.arquivo?
  end
  
  def image_tag_sumario
    image_tag "/assets/verso/sumario-128.png", :width=>64
  end

end
