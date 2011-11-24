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
  
end
