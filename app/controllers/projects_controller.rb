class ProjectsController < ApplicationController
  before_filter :login_required
  
  def index
    @projects = Project.includes(:subject, :degree, :project_versions)
    @projects = @projects.where(:subject_id=>params[:subject]) if params[:subject] && @subject = Subject.find(params[:subject])
    @projects = @projects.where(:degree_id=>params[:degree])   if params[:degree]  && @degree  = Degree.find(params[:degree])
  end

  def show
    @project   = Project.find(params[:id])
    @subject   = @project.subject
    @degree    = @project.degree
    @project_version = @project.versions.build
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
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Aula removida."
  end
end
