class ProjectsController < ApplicationController
  before_filter :login_required
  
  
  # GET /project/:project_version_id/:attribute
  def swf
    v = ProjectVersion.find(params[:project_version_id])
    @paperclip = v.send("swf#{params[:swf_token]}")
  end
  
  #RESOURCE
  
  def index
    @projects = Project.includes(:subject, :degree)
    @projects = @projects.versionadas if params[:versioned].present?
    @projects = @projects.sem_animacoes if params[:with_animations]=="1"
    @projects = @projects.com_animacoes if params[:with_animations]=="2"
    @projects = @projects.sem_recursos if params[:with_resources]=="1"
    @projects = @projects.com_recursos if params[:with_resources]=="2"
    @projects = @projects.where(:subject_id=>params[:subject]) if params[:subject]
    @projects = @projects.where(:degree_id=>params[:degree])   if params[:degree]
    @projects = @projects.where(:numero=>params[:numero])      if params[:numero]
    @projects = @projects.where(:status_revisao_texto=>params[:status_revisao_texto])  if params[:status_revisao_texto]
    @projects = @projects.where(:status_revisao_final=>params[:status_revisao_final])  if params[:status_revisao_final]
    @projects = @projects.where(:status_revisao_audio=>params[:status_revisao_audio])  if params[:status_revisao_audio]
    @projects = @projects.where(:status_revisao_metodo=>params[:status_revisao_metodo])  if params[:status_revisao_metodo]
    @projects = @projects.where(:status_producao=>params[:status_producao])  if params[:status_producao]
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
