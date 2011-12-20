class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
  helper_method :filtros
  
  def filtros
    #return JSON.parse(cookies[:filtros]) if cookies[:filtros].present?
    #{}
    session[:filtros] ||= {}
  end
  
end
