module ReviewsHelper

  def review_css(review)
    status =  if review.aprovou?
                "notice"
              elsif review.precisa_revisar?
                "alert"
              else
                "error"
              end
    "flash #{status}"
  end
  
  
  
  def review_tipo_image_tag(review)
    url = if review.ortografica?
      'verso/review/texto.png'
    elsif review.audio?
      'verso/review/audio.png'
    elsif review.flash?
      'verso/review/flash.png'
    else
      'verso/review/metodo.png'
    end
    review_image_tag(url, 'tipo')
  end
  
  def review_corrigiu_image_tag(review)
    review_image_tag('verso/review/corrigiu.png', 'corrigiu') if review.corrigiu?
  end
  
  def review_revisou_image_tag(review)
    return unless review.revisou?
    return review_image_tag('verso/review/corrigiu.png', 'revisou') if review.aprovou?
    review_image_tag('verso/review/reprovou.png', 'revisou')
  end


  def review_image_tag(key, css)
    image_tag key, :width=>32, :class=>css
  end
end
