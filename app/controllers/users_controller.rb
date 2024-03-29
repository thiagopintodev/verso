class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Cadastro realizado, voce ja esta conectado."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Seus dados foram atualizados."
    else
      render :action => 'edit'
    end
  end
  
  def show
    @user = params.has_key?(:id) ? User.find(params[:id])
                                 : User.u(params[:usuario])
    unless @user
      flash[:error] = "Usuario Nao Existe"
      return redirect_to root_url
    end
  end
  
end
