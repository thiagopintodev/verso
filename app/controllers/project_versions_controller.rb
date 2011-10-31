class ProjectVersionsController < ApplicationController
  # GET /project_versions
  # GET /project_versions.json
  def index
    @project_versions = ProjectVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_versions }
    end
  end

  # GET /project_versions/1
  # GET /project_versions/1.json
  def show
    @project_version = ProjectVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project_version }
    end
  end

  # GET /project_versions/new
  # GET /project_versions/new.json
  def new
    @project_version = ProjectVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_version }
    end
  end

  # GET /project_versions/1/edit
  def edit
    @project_version = ProjectVersion.find(params[:id])
  end

  # POST /project_versions
  # POST /project_versions.json
  def create
    @project_version = ProjectVersion.new(params[:project_version])

    respond_to do |format|
      if @project_version.save
        format.html { redirect_to @project_version, notice: 'Project version was successfully created.' }
        format.json { render json: @project_version, status: :created, location: @project_version }
      else
        format.html { render action: "new" }
        format.json { render json: @project_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project_versions/1
  # PUT /project_versions/1.json
  def update
    @project_version = ProjectVersion.find(params[:id])

    respond_to do |format|
      if @project_version.update_attributes(params[:project_version])
        format.html { redirect_to @project_version, notice: 'Project version was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_versions/1
  # DELETE /project_versions/1.json
  def destroy
    @project_version = ProjectVersion.find(params[:id])
    @project_version.destroy

    respond_to do |format|
      format.html { redirect_to project_versions_url }
      format.json { head :ok }
    end
  end
end
