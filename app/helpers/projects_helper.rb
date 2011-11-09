module ProjectsHelper

  def projects_filter_path(options)
    p = params.clone
    defaults = {:action=>'index', :id=>nil}
    disablers = [:subject, :degree, :versioned]
    options.each do |k,v|
      next unless disablers.include?(k)
      options[k].to_s == p[k] ? p.delete(k) : ( p[k] = v )
    end
    p.merge defaults
  end

end
