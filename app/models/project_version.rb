class ProjectVersion < ActiveRecord::Base
  belongs_to :project, :counter_cache=>true
  belongs_to :user
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  include Revisao
  
  
  validates :texto, :length => { :minimum => 5 }
  
  has_attached_file :fla,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf1,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf2,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf3,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf4,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
  validates_attachment_presence :fla
  
  validates_attachment_content_type :fla,
                                    :content_type => [ 'application/octet-stream' ],
                                    :message => 'nao indica que este seja um arquivo .FLA'
  validates_attachment_content_type :swf1,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf2,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf3,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf4,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  
  def altera_revisao_texto(status, user=nil)
    return if status.nil?
    user ||= User.find_by_username('auto')
    return unless user.is_revisao_texto?
    #
    self.user_revisao_texto   = user
    self.status_revisao_texto = status
  end
  
  def altera_revisao_final(status, user=nil)
    return if status.nil?
    user ||= User.find_by_username('auto')
    return unless user.is_revisao_final?
    #
    self.user_revisao_final   = user
    self.status_revisao_final = status
  end
  
  after_save do
    v = project.versions.last
    project.status_revisao_texto = v.status_revisao_texto
    project.status_revisao_final = v.status_revisao_final
    project.user_revisao_texto   = v.user_revisao_texto
    project.user_revisao_final   = v.user_revisao_final
    project.save
  end
  
end
