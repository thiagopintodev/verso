class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :degree
  has_many :reviews
  has_many :project_versions
  alias :versions   :project_versions
  
  
  has_many :animations, :class_name => 'ProjectVersion', :conditions=> {:tipo=>ProjectVersion::TIPO_ANIMACAO}
  has_many :resources,  :class_name => 'ProjectVersion', :conditions=> {:tipo=>ProjectVersion::TIPO_RECURSO}
  
  
  
  accepts_nested_attributes_for :project_versions, :allow_destroy => true, :reject_if => :all_blank
  
  scope :versionadas, where('project_animations_count > 0 OR project_resources_count > 0')
  scope :com_animacoes, where('project_animations_count > 0')
  scope :com_recursos, where('project_resources_count > 0')
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_audio, :class_name=>'User', :foreign_key => 'user_id_revisao_audio'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  
  AULAS = (1..12).to_a
  
  #
  PRODUCAO_NAO = 0
  PRODUCAO_SIM = 1
  
  PRODUCAO_HASH = {
    PRODUCAO_NAO=>('NAO ENVIADO PARA O AVA'),
    PRODUCAO_SIM=>('ENVIADO PARA O AVA')
  }
  
  PRODUCAO_ARRAY = [
    [PRODUCAO_HASH[0], 0],
    [PRODUCAO_HASH[1], 1]
  ]
  
  #
  REVISAO_NAO       = 0
  REVISAO_REJEITADO = 1
  REVISAO_CORRIGIDO = 2
  REVISAO_APROVADO  = 3
  
  REVISOES_HASH = {
    REVISAO_NAO=>('NAO REVISADO'),
    REVISAO_REJEITADO=>('REJEITADO'),
    REVISAO_CORRIGIDO=>('CORRIGIDO'),
    REVISAO_APROVADO=>('APROVADO')
  }
  
  REVISOES = [
    [REVISOES_HASH[0], 0],
    [REVISOES_HASH[1], 1],
    [REVISOES_HASH[2], 2],
    [REVISOES_HASH[3], 3]
  ]
  
  has_attached_file :capa,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
  validates_presence_of :numero
  validates_uniqueness_of :numero, :scope => [:subject_id, :degree_id]
  
  def nome
    "#{numero}a Aula"
  end
  
  def nome_completo
    "#{subject.nome}, #{degree.to_s}, #{nome}"
  end
  
  #enviado para o ava?
  def producao?
    PRODUCAO_SIM == status_producao
  end
  
  def producao
    PRODUCAO_HASH[status_producao]
  end
  
  #passou pelas 3 revisoes?
  def revisado?
    REVISAO_APROVADO == status_revisao_texto &&
    REVISAO_APROVADO == status_revisao_audio &&
    REVISAO_APROVADO == status_revisao_final &&
    REVISAO_APROVADO == status_revisao_metodo
  end
  
  def texto_revisado?
    REVISAO_NAO != status_revisao_texto
  end
  def audio_revisado?
    REVISAO_NAO != status_revisao_audio
  end
  def flash_revisado?
    REVISAO_NAO != status_revisao_final
  end
  def metodo_revisado?
    REVISAO_NAO != status_revisao_metodo
  end
  
  def revisao_texto
    REVISOES_HASH[status_revisao_texto]
  end
  def revisao_final
    REVISOES_HASH[status_revisao_final]
  end
  def revisao_audio
    REVISOES_HASH[status_revisao_audio]
  end
  def revisao_metodo
    REVISOES_HASH[status_revisao_metodo]
  end
  
  def versao_final(attribute)
    (@final ||= {}).fetch(attribute) do
      attributes = [:fla, :aud1, :aud2, :aud3, :aud4, :swf1, :swf2, :swf3, :swf4]
      attributes.each do |a|
        @final[a] = ProjectVersion.new
        versions.each { |v| @final[a] = v if v.send(a).present? }
      end
      @final[attribute]
    end
  end
  
  before_validation do
    self.status_revisao_audio = reviews.audios.minimum(:status)  || 0
    self.status_revisao_texto = reviews.textos.minimum(:status)  || 0
    self.status_revisao_final = reviews.flashes.minimum(:status) || 0
    self.status_revisao_metodo = reviews.metodologicas.minimum(:status) || 0
    true
  end
  
  after_save do
    self.class.limpar_cached
  end
  
  class << self
    def cached_quantidade
      Rails.cache.fetch([:project, :count]) { count }
    end
    def cached_quantidade_versionadas
      Rails.cache.fetch([:project, :count, :versioned]) { versionadas.count }
    end
    
    def cached_group_tipo
      Rails.cache.fetch([:project, :count, :versioned, :by_tipo]) do
        r={}
        ProjectVersion::TIPOS_HASH.map { |tipo, nome| r[tipo] = ProjectVersion.where(:tipo=>tipo).group(:project_id).size.size }
        r
      end
    end
    
    def cached_group_revisao_texto
      Rails.cache.fetch([:project, :count, :versioned, :by_texto]) { versionadas.select('status_revisao_texto, count(*)').group(:status_revisao_texto).count }
    end
    
    def cached_group_revisao_audio
      Rails.cache.fetch([:project, :count, :versioned, :by_audio]) { versionadas.select('status_revisao_audio, count(*)').group(:status_revisao_audio).count }
    end
    
    def cached_group_revisao_final
      Rails.cache.fetch([:project, :count, :versioned, :by_final]) { versionadas.select('status_revisao_final, count(*)').group(:status_revisao_final).count }
    end
    
    def cached_group_revisao_metodo
      Rails.cache.fetch([:project, :count, :versioned, :by_metodo]) { versionadas.select('status_revisao_metodo, count(*)').group(:status_revisao_metodo).count }
    end
    
    def cached_group_degree
      Rails.cache.fetch([:project, :count, :versioned, :by_degree]) { versionadas.select('degree_id, count(*)').group(:degree_id).count }
    end
    
    def cached_group_subject
      Rails.cache.fetch([:project, :count, :versioned, :by_subject]) { versionadas.select('subject_id, count(*)').group(:subject_id).count }
    end
    
    def cached_group_numero
      Rails.cache.fetch([:project, :count, :versioned, :by_numero]) { versionadas.select('numero, count(*)').group(:numero).count }
    end
    
    def cached_group_producao
      Rails.cache.fetch([:project, :count, :versioned, :by_producao]) { versionadas.select('status_producao, count(*)').group(:status_producao).count }
    end
    
    def limpar_cached
      Rails.cache.delete([:project, :count])
      Rails.cache.delete([:project, :count, :versioned])
      Rails.cache.delete([:project, :count, :versioned, :by_tipo])
      Rails.cache.delete([:project, :count, :versioned, :by_texto])
      Rails.cache.delete([:project, :count, :versioned, :by_audio])
      Rails.cache.delete([:project, :count, :versioned, :by_final])
      Rails.cache.delete([:project, :count, :versioned, :by_metodo])
      Rails.cache.delete([:project, :count, :versioned, :by_degree])
      Rails.cache.delete([:project, :count, :versioned, :by_subject])
      Rails.cache.delete([:project, :count, :versioned, :by_numero])
      Rails.cache.delete([:project, :count, :versioned, :by_producao])
    end
  end
end
