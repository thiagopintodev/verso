class ProjectVersion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_audio, :class_name=>'User', :foreign_key => 'user_id_revisao_audio'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  
  validates :project, :presence=>true
  validates :user,    :presence=>true
  
  TIPO_ANIMACAO=0
  TIPO_RECURSO=1
  
  TIPOS_HASH = {
    TIPO_ANIMACAO => "Animacao",
    TIPO_RECURSO  => "Recurso"
  }
  
  TIPOS = [
    [TIPOS_HASH[0], 0],
    [TIPOS_HASH[1], 1]
  ]
                       
  scope :tipo_animacao, where(:tipo=>TIPO_ANIMACAO)
  scope :tipo_recurso,  where(:tipo=>TIPO_RECURSO)
  
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
  
  FLA_VALIDATIONS = { :content_type => [ 'application/octet-stream' ], :message => 'nao indica que este seja um arquivo .FLA (application/octet-stream)' }
  SWF_VALIDATIONS = { :content_type => [ 'application/x-shockwave-flash' ], :message => 'nao indica que este seja um arquivo .SWF (application/x-shockwave-flash)' }
  
  validates_attachment_content_type :fla, FLA_VALIDATIONS
  
  validates_attachment_content_type :swf1, SWF_VALIDATIONS
  validates_attachment_content_type :swf2, SWF_VALIDATIONS
  validates_attachment_content_type :swf3, SWF_VALIDATIONS
  validates_attachment_content_type :swf4, SWF_VALIDATIONS
  
  validate do
    return errors[:fla] = "Voce deve enviar pelo menos um arquivo" if not algum_swf? and not algum_aud? and not fla?
    return errors[:fla] = "Voce nao pode enviar arquivos SWF sem enviar o FLA" if algum_swf? and not fla?
    return errors[:swf1] = "Voce nao pode enviar o FLA sem enviar ao menos um SWF" if not algum_swf? and fla?
  end
  
  def algum_swf?
    swf1? || swf2? || swf3? || swf4?
  end
  
  def algum_aud?
    aud1? || aud2? || aud3? || aud4?
  end
  
  def tipo_animacao?
    tipo==TIPO_ANIMACAO
  end
  
  def tipo_recurso?
    tipo==TIPO_RECURSO
  end
  
  before_validation do
    antes = project.versions.last.sequencia rescue 0
    self.sequencia = antes+1
    true
  end
  
  after_save    :update_counter_cache
  after_destroy :update_counter_cache
  
  def update_counter_cache
    self.project.project_animations_count = self.project.animations.count
    self.project.project_resources_count  = self.project.resources.count
    self.project.save
  end
end
