class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => "Acesso garantido."
    else
      flash.now[:alert] = "Acesso negado."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => "Desconectado."
  end
end
