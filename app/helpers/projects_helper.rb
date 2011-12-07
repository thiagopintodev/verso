module ProjectsHelper

  def projects_filter_path(options={})
    params.merge(options).merge({:action=>'index', :id=>nil})
  end
  
  def li_my_options(key, valor_esperado)
    if valor_esperado.nil?
      return unless params[key].nil?
    else
      return unless valor_esperado == params[key]
    end
    {:class=>'selected'}
  end
  
  def li_filtro(key, valor_esperado, texto, quantidade=nil)
    texto ||= valor_esperado
    content_tag :li, li_my_options(key, valor_esperado) do
      s = "#{texto} "
      s << "(#{content_tag(:b, quantidade)})" unless quantidade.nil?
      link_to raw(s), projects_filter_path(key=>valor_esperado)
    end
  end
  
  def li_filtro_relatorio_uploads(user)
    a1 = params[:user_ids] || []
    a2 = [user.id.to_s]
    new_params = (a1|a2) - (a1 & a2)
    css = 'selected' if a1.include?(user.id.to_s)
    url = relatorio_projects_path(:user_ids => new_params)
    q2 = user.project_versions.count
    if (q2.zero?)
      txt = user.u_
      title = "este usuario nao cadastra aulas"
    else
      q1 = user.project_versions.select('distinct project_id').count
      txt = "#{user.u_} (#{q1} / #{q2})"
      title = "#{user.u_} interagiu com #{q1} aulas, totalizando #{q2} uploads"
    end
    content_tag :li, link_to(txt, url, :title=>title), :class=>css
  end
  
  def myfile(img_html, paperclip, url=nil)
    return unless paperclip.present?
    url ||= paperclip.url
    content = raw("#{img_html} #{paperclip.original_filename} (#{number_to_human_size(paperclip.size)})")
    link_to content, url, :target=>'_blank'
  end
  
  def myfile_title(img_html, paperclip, url=nil)
    return unless paperclip.present?
    url ||= paperclip.url
    title = "#{paperclip.original_filename} (#{number_to_human_size(paperclip.size)})"
    link_to img_html, url, :target=>'_blank', :title=>title
  end
  
  def myupload(form, field, img_html, texto)
    label_tag do
      raw "#{img_html} #{texto} #{form.file_field field}"
    end
  end
  
  def myfile_swf(paperclip, swf_path)
    return unless paperclip.present?
    content = raw("#{image_swf(:width=>16)} #{paperclip.original_filename} (#{number_to_human_size(paperclip.size)})")
    raw [
      link_to(content, paperclip.url, :target=>'_blank'),
      link_to(image_play(:width=>16, :style=>"float:right"), swf_path, :target=>'_blank')
    ].join
  end
  
end
