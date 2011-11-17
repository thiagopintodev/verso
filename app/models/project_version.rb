class ProjectVersion < ActiveRecord::Base
  belongs_to :project, :counter_cache=>true
  belongs_to :user
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_audio, :class_name=>'User', :foreign_key => 'user_id_revisao_audio'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  
  Paperclip.interpolates :created_at  do |attachment, style|
    attachment.instance.created_at.strftime("%Y_%h_%d")
  end
  
  PAPERCLIP_DEFAULT_URL = "/arquivos/diario/:created_at/:class/:id/:attachment/:filename"
  PAPERCLIP_DEFAULT_OPTIONS = { :url  => PAPERCLIP_DEFAULT_URL, :path => ":rails_root/public#{PAPERCLIP_DEFAULT_URL}" }
  
  has_attached_file :fla,  PAPERCLIP_DEFAULT_OPTIONS
  
  has_attached_file :swf1, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :swf2, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :swf3, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :swf4, PAPERCLIP_DEFAULT_OPTIONS
  
  has_attached_file :aud1, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :aud2, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :aud3, PAPERCLIP_DEFAULT_OPTIONS
  has_attached_file :aud4, PAPERCLIP_DEFAULT_OPTIONS
  
  FLA_VALIDATIONS = { :content_type => [ 'application/octet-stream' ], :message => 'nao indica que este seja um arquivo .FLA' }
  SWF_VALIDATIONS = { :content_type => [ 'application/x-shockwave-flash' ], :message => 'nao indica que este seja um arquivo .SWF' }
  MP3_VALIDATIONS = { :content_type => [ 'audio/mp3' ], :message => 'nao indica que este arquivo seja do tipo \'audio/mp3\'' }
  
  #validates_attachment_presence :fla
  validates :texto, :length => {:minimum=>5}
  
  validates_attachment_content_type :fla, FLA_VALIDATIONS
  
  validates_attachment_content_type :swf1, SWF_VALIDATIONS
  validates_attachment_content_type :swf2, SWF_VALIDATIONS
  validates_attachment_content_type :swf3, SWF_VALIDATIONS
  validates_attachment_content_type :swf4, SWF_VALIDATIONS
                                    
  validates_attachment_content_type :aud1, MP3_VALIDATIONS
  validates_attachment_content_type :aud2, MP3_VALIDATIONS
  validates_attachment_content_type :aud3, MP3_VALIDATIONS
  validates_attachment_content_type :aud4, MP3_VALIDATIONS
  
  
  
  
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
  
  def altera_revisao_audio(status, user=nil)
    return if status.nil?
    user ||= User.find_by_username('auto')
    return unless user.is_revisao_audio?
    #
    self.user_revisao_audio   = user
    self.status_revisao_audio = status
  end
=begin
  after_save do
    v = project.versions.last
    project.status_revisao_texto = v.status_revisao_texto
    project.status_revisao_audio = v.status_revisao_audio
    project.status_revisao_final = v.status_revisao_final
    project.user_revisao_texto   = v.user_revisao_texto
    project.user_revisao_audio   = v.user_revisao_audio
    project.user_revisao_final   = v.user_revisao_final
    project.save
  end
=end
end
