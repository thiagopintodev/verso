class AnimationsController < ApplicationController
  before_filter :login_required
  
  def index
    @animations = Animation.all
  end

  def show
    @animation = Animation.find(params[:id])
    @project   = @animation.project
    @subject   = @project.subject
    @degree    = @project.degree
  end

  def new
    @animation = Animation.new
  end

  def create
    @animation = Animation.new(params[:animation])
    @project.user_id = current_user.id
    if @animation.save
      redirect_to @animation, :notice => "Animacao Criada, cadastre sua primeira versao."
    else
      render :action => 'new'
    end
  end

  def edit
    @animation = Animation.find(params[:id])
  end

  def update
    @animation = Animation.find(params[:id])
    if @animation.update_attributes(params[:animation])
      redirect_to @animation, :notice  => "Animacao atualizada."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @animation = Animation.find(params[:id])
    @animation.destroy
    redirect_to animations_url, :notice => "Animacao destruida."
  end
end
