module ProjectsHelper

  def projects_filter_path(options)
    p = params.clone
    defaults = {:action=>'index', :id=>nil}
    disablers = [:subject, :degree, :versioned, :status_revisao_texto, :status_revisao_final, :status_revisao_audio]
    options.each do |k,v|
      next unless disablers.include?(k)
      options[k].to_s == p[k].to_s ? p.delete(k) : ( p[k] = v )
    end
    p.merge defaults
  end

end
