module ImagesHelper

  def image_mp3(options={})
    image_tag('verso/Mp3-32.png', options)
  end
  
  def image_swf(options={})
    image_tag('verso/Swf-32.png', options)
  end
  
  def image_fla(options={})
    image_tag('verso/Fla-32.png', options)
  end
  
  def image_enviando
    image_tag('verso/enviando.gif', :id=>'enviando', :style=>'display:none')
  end

end
