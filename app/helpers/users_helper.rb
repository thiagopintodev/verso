module UsersHelper
  
  def link_to_usuario(user, options={})
    h = {:style=>'color:#33f'}
    link_to(user.u_, usuario_path(user.username), h.merge(options))
  end

end
