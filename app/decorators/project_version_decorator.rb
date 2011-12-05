class ProjectVersionDecorator < ApplicationDecorator
  decorates :project_version

  def conteudo_usuario
    h.raw [
      #h.image_tag "/assets/aspire/page/author.jpg",
      h.content_tag(:strong, "v. #{sequencia} "),
      h.link_to_usuario(user),
      h.content_tag(:small, created_at.strftime(" %d/%m/%y %H:%M:%S"))
    ].join
  end
  
  def conteudo_arquivos_capa
    if new_record?
      h.form_for model.project, :html=>{:multipart=>true, :class=>'aspire'} do |f|
        ps = []
        ps << f.error_messages
        ps << h.content_tag(:p, h.myupload(f,  :capa, h.image_img, "Capa *.JPG"))
        ps << h.content_tag(:div, :class=>'direita', :style=>'margin-bottom:100px') do
                h.raw [
                  h.image_enviando,
                  h.submit_tag("Cadastrar Animacoes", :class=>"button", :confirm => "Tem Certeza?")
                ].join
              end
        h.raw ps.join
      end
    end
  end
  
  def conteudo_arquivos_animacao
    if new_record?
      h.form_for model.project, :html=>{:multipart=>true, :class=>'aspire'} do |f|
        f.fields_for :project_versions, model do |f2|
          ls = []
          ls << h.myupload(f2, :fla, h.image_fla, "Fontes *.FLA")
          ls << h.myupload(f2, :swf1, h.image_swf, "Cena 1 *.SWF")
          ls << h.myupload(f2, :swf2, h.image_swf, "Cena 2 *.SWF")
          ls << h.myupload(f2, :swf3, h.image_swf, "Cena 3 *.SWF")
          ls << h.myupload(f2, :swf4, h.image_swf, "Cena 4 *.SWF")
          ls << h.myupload(f,  :capa, h.image_img, "Capa *.JPG")
          ls = ls.map { |i| h.content_tag :p, i }
          
          ps = []
          ps << f2.error_messages
          ps << f2.hidden_field(:project_id)
          ps << f2.hidden_field(:user_id)
          ps << f2.hidden_field(:tipo)
          ps << ls.join
          ps << f2.text_area(:texto, :rows=>10, :style=>"width: 300px")
          ps << h.content_tag(:div, :class=>'direita') do
                  h.raw [
                    h.image_enviando,
                    h.submit_tag("Cadastrar Animacoes", :class=>"button", :confirm => "Tem Certeza?")
                  ].join
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
      ps << h.content_tag(:p, h.raw(ls.join))
      
      h.raw ps.join
    end
  end
  
  def conteudo_arquivos_recurso
    if new_record?
      h.form_for model.project, :html=>{:multipart=>true, :class=>'aspire'} do |f|
        f.fields_for :project_versions, model do |f2|
          ls = []
          #ls << h.myupload(f2, :doc, h.image_doc, "ROTEIRO *.DOC")
          ls << h.myupload(f2, :aud1, h.image_mp3, "Cena 1 *.MP3")
          ls << h.myupload(f2, :aud2, h.image_mp3, "Cena 2 *.MP3")
          ls << h.myupload(f2, :aud3, h.image_mp3, "Cena 3 *.MP3")
          ls << h.myupload(f2, :aud4, h.image_mp3, "Cena 4 *.MP3")
          ls = ls.map { |i| h.content_tag :p, i }
          
          ps = []
          ps << f2.error_messages
          ps << f2.hidden_field(:project_id)
          ps << f2.hidden_field(:user_id)
          ps << f2.hidden_field(:tipo)
          ps << ls.join
          ps << f2.text_area(:texto, :rows=>10, :style=>"width: 300px")
          ps << h.content_tag(:div, :class=>'direita') do
                  h.raw [
                    h.image_enviando,
                    h.submit_tag("Cadastrar Recursos", :class=>"button", :confirm => "Tem Certeza?")
                  ].join
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
      ps << h.content_tag(:p, h.raw(ls.join))
      
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

  # Defining an Interf2ce
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
