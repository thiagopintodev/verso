module ProjectsHelper

  def projects_filter_path(options)
    p = params.clone
    defaults = {:action=>'index', :id=>nil}
    disablers = [:subject, :degree]
    options.each do |k,v|
      if disablers.include?(k)
        puts [options[k], p[k]].to_s
        if options[k].to_s == p[k]
          p.delete k
        else
          p[k] = v
        end
      end
    end
    p.merge defaults
    #params[:action] == 'show' ? projects_path(:subject=>subject.id) : params.merge(:subject=>subject.id)
  end

end
