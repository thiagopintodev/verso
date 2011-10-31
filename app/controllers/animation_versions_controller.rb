class AnimationVersionsController < ApplicationController
  before_filter :login_required
  

  def index
    @animation_versions = AnimationVersion.all
  end
  
  def new
    @animation_version = AnimationVersion.new
  end

  def create
    @animation_version = AnimationVersion.new(params[:animation_version])
    @animation_version.user_id = current_user.id
    if @animation_version.save
      redirect_to animation_path(@animation_version.animation_id), :notice => "Nova Versao cadastrada com sucesso."
    else
      render :action => 'new'
    end
  end
end
