class ProjectVersionDecorator < ApplicationDecorator
  decorates :project_version

  def conteudo_esquerda
    t = new_record? ? Time.now : created_at
    h.raw [
      #h.image_tag "/assets/aspire/page/author.jpg",
      "@#{user.username}",
      h.content_tag(:small, t.strftime("%d/%m/%y %H:%M:S")),
      h.content_tag(:strong, "v. #{sequencia}")
    ].join(h.content_tag(:br))
  end
  
  def conteudo_direita_animacao
    if new_record?
      h.form_for model.project, :html=>{:multipart=>true, :class=>'aspire'} do |f|
        f.fields_for :project_versions, model do |fa|
          ls = []
          ls << h.myupload(fa, :fla, h.image_fla, "FONTES *.FLA")
          ls << h.myupload(fa, :swf1, h.image_swf, "CENA 1 *.SWF")
          ls << h.myupload(fa, :swf2, h.image_swf, "CENA 2 *.SWF")
          ls << h.myupload(fa, :swf3, h.image_swf, "CENA 3 *.SWF")
          ls << h.myupload(fa, :swf4, h.image_swf, "CENA 4 *.SWF")
          ls = ls.map { |i| h.content_tag :p, i }
          
          ps = []
          ps << fa.error_messages
          ps << fa.hidden_field(:project_id)
          ps << fa.hidden_field(:user_id)
          ps << fa.hidden_field(:tipo)
          ps << ls.join
          ps << fa.text_area(:texto, :rows=>10, :style=>"width: 300px")
          ps << h.content_tag(:div, :class=>'direita') do
                  h.submit_tag "Cadastrar Animacoes", :class=>"button"
                end
                
          h.raw ps.join
        end
      end
    else
      ls = []
      ls << if fla? then h.myfile_title(h.image_fla, fla)
                     else h.content_tag(:span)
                     end
      ls << if swf1? then h.myfile_title(h.image_swf, swf1, h.swf_path(id, 1))
                     else h.content_tag(:span)
                     end
      ls << if swf2? then h.myfile_title(h.image_swf, swf2, h.swf_path(id, 2))
                     else h.content_tag(:span)
                     end
      ls << if swf3? then h.myfile_title(h.image_swf, swf3, h.swf_path(id, 3))
                     else h.content_tag(:span)
                     end
      ls << if swf4? then h.myfile_title(h.image_swf, swf4, h.swf_path(id, 4))
                     else h.content_tag(:span)
                     end
      
    
    
      t = texto.blank? ? h.raw("<b>***Nao foram escritos comentarios***</b>") : texto
      ps = []
      ps << h.content_tag(:p, t)
      ps << ls.join
      
      h.raw ps.join
    end
  end
  
  def conteudo_direita_recurso
    if new_record?
      h.form_for model.project, :html=>{:multipart=>true, :class=>'aspire'} do |f|
        f.fields_for :project_versions, model do |fr|
          ls = []
          #ls << h.myupload(fr, :doc, h.image_doc, "ROTEIRO *.DOC")
          ls << nil
          ls << h.myupload(fr, :aud1, h.image_mp3, "CENA 1 *.MP3")
          ls << h.myupload(fr, :aud2, h.image_mp3, "CENA 2 *.MP3")
          ls << h.myupload(fr, :aud3, h.image_mp3, "CENA 3 *.MP3")
          ls << h.myupload(fr, :aud4, h.image_mp3, "CENA 4 *.MP3")
          ls = ls.map { |i| h.content_tag :p, i }
          
          ps = []
          ps << fr.error_messages
          ps << fr.hidden_field(:project_id)
          ps << fr.hidden_field(:user_id)
          ps << fr.hidden_field(:tipo)
          ps << ls.join
          ps << fr.text_area(:texto, :rows=>10, :style=>"width: 300px")
          ps << h.content_tag(:div, :class=>'direita') do
                  h.submit_tag "Cadastrar Recursos", :class=>"button"
                end
                
          h.raw ps.join
        end
      end
    else
      ls = []
      #ls << h.myfile_title(h.image_doc, doc) if doc?
      ls << if aud1? then h.myfile_title(h.image_mp3, aud1)
                     else h.content_tag(:span)
                     end
      ls << if aud2? then h.myfile_title(h.image_mp3, aud2)
                     else h.content_tag(:span)
                     end
      ls << if aud3? then h.myfile_title(h.image_mp3, aud3)
                     else h.content_tag(:span)
                     end
      ls << if aud4? then h.myfile_title(h.image_mp3, aud4)
                     else h.content_tag(:span)
                     end
      
      t = texto.blank? ? h.raw("<b>***Nao foram escritos comentarios***</b>") : texto
      ps = []
      ps << h.content_tag(:p, t)
      ps << ls.join
      
      h.raw ps.join
    end
  end
  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #   
  #   Or, optionally enable "lazy helpers" by calling this method:
  #     lazy_helpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #   
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"), 
  #                   :class => 'timestamp'
  #   end
end
