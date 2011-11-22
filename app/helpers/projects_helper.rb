module ProjectsHelper

  def projects_filter_path(options)
    options.merge({:action=>'index', :id=>nil})
  end
  
  def li_subject_options(subject)
    if subject.nil?
      return unless params[:subject].nil?
    else
      return unless subject.id.to_s == params[:subject]
    end
    {:class=>'selected'}
  end
  
  def li_degree_options(degree)
    if degree.nil?
      return unless params[:degree].nil?
    else
      return unless degree.id.to_s == params[:degree]
    end
    {:class=>'selected'}
  end
end
