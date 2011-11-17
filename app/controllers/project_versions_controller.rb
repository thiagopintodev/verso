class ProjectVersionsController < ApplicationController

  # GET /project_versions/:id/:attribute
  def swf
    v = ProjectVersion.find(params[:project_version_id])
    @paperclip = v.send("swf#{params[:swf_token]}")
  end
  
  # POST /project_versions
  # POST /project_versions.json
  def create
    @project_version = ProjectVersion.new(params[:project_version])
    @project_version.user_id = current_user.id
    if @project_version.save
      redirect_to project_path(@project_version.project_id), :notice => "Nova Versao cadastrada com sucesso."
    else
      render :action => 'new'
    end
  end
  
=begin
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
=end
end
