class ProjectsController < ApplicationController
  before_filter :login_required
  
  
  # GET /project/:project_version_id/:attribute
  def swf
    v = ProjectVersion.find(params[:project_version_id])
    @paperclip = v.send("swf#{params[:swf_token]}")
  end
  
  #GET relatorio (COLLECTION)
  def relatorio
    project_versions = ProjectVersion.includes(:project)
    project_versions = project_versions.where(:user_id=>params[:user_ids]) if params[:user_ids]
    
    @pvs_by_date = {}
    project_versions.reverse.each do |v|
      (@pvs_by_date[v.created_at.to_date] ||= []) << v
    end
  end
  
  #RESOURCE
  
  def index
    #puts params[:filtros]#.symbolize_keys
    #filtros_merge params[:filtros]
    filtros.clear if params[:limpar_filtro]
    filtros.merge! params[:filtros] if params[:filtros]
    @projects = Project.includes(:subject, :degree)
    @projects = @projects.versionadas   if filtros['versioned'].present?
    @projects = @projects.sem_animacoes if filtros['with_animations']=="1"
    @projects = @projects.com_animacoes if filtros['with_animations']=="2"
    @projects = @projects.sem_recursos if filtros['with_resources']=="1"
    @projects = @projects.com_recursos if filtros['with_resources']=="2"
    @projects = @projects.where(:subject_id=>filtros['subject']) if filtros['subject']
    @projects = @projects.where(:degree_id=>filtros['degree'])   if filtros['degree']
    @projects = @projects.where(:numero=>filtros['numero'])      if filtros['numero']
    @projects = @projects.where(:status_revisao_texto=>filtros['status_revisao_texto'])    if filtros['status_revisao_texto']
    @projects = @projects.where(:status_revisao_final=>filtros['status_revisao_final'])    if filtros['status_revisao_final']
    @projects = @projects.where(:status_revisao_audio=>filtros['status_revisao_audio'])    if filtros['status_revisao_audio']
    @projects = @projects.where(:status_revisao_metodo=>filtros['status_revisao_metodo'])  if filtros['status_revisao_metodo']
    @projects = @projects.where(:status_producao=>filtros['status_producao'])              if filtros['status_producao']
    @projects_count = @projects.count
    @projects = @projects.page(params[:page]).per(21)
  end

  def show
    @project = Project.find(params[:id])
    if current_user.is_cadastrador?
      @project.project_versions.build(:user=>current_user, :tipo=>ProjectVersion::TIPO_ANIMACAO)
      @project.project_versions.build(:user=>current_user, :tipo=>ProjectVersion::TIPO_RECURSO)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    if @project.save
      redirect_to @project, :notice => "Nova Aula Criada."
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Aula foi atualizada."
    else
      flash[:error] = "Ocorreu um Erro, veja detalhes abaixo"
      render :action => 'show'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Aula removida."
  end
end
