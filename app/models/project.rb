class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :degree
  has_many :reviews
  has_many :project_versions
  alias :versions :project_versions
  
  scope :versionadas, where('project_versions_count > 0')
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_audio, :class_name=>'User', :foreign_key => 'user_id_revisao_audio'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'

  
  AULAS = (1..12).to_a
  
  #
  PRODUCAO_NAO = 0
  PRODUCAO_SIM = 1
  
  PRODUCAO_HASH = {
    0=>('NAO ENVIADO PARA O AVA'),
    1=>('ENVIADO PARA O AVA')
  }
  
  PRODUCAO_ARRAY = [
    [PRODUCAO_HASH[0], 0],
    [PRODUCAO_HASH[1], 1]
  ]
  
  #
  REVISAO_NAO       = 0
  REVISAO_REJEITADO = 1
  REVISAO_REPROVADO = 1
  REVISAO_APROVADO  = 2
  
  REVISOES_HASH = {
    0=>('NAO REVISADO'),
    1=>('REJEITADO'),
    2=>('APROVADO')
  }
  
  REVISOES = [
    [REVISOES_HASH[0], 0],
    [REVISOES_HASH[1], 1],
    [REVISOES_HASH[2], 2]
  ]
  
  has_attached_file :capa,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
  validates_presence_of :numero
  validates_uniqueness_of :numero, :scope => [:subject_id, :degree_id]
  
  def nome
    "#{numero}a Aula"
  end
  
  #enviado para o ava?
  def producao?
    status_producao==1
  end
  
  #passou pelas 3 revisoes?
  def revisado?
    REVISAO_APROVADO == status_revisao_texto &&
    REVISAO_APROVADO == status_revisao_audio &&
    REVISAO_APROVADO == status_revisao_final
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
  
  
  def recalcula_revisoes
    #audio
    @revisoes = reviews.audios
    unless @revisoes.size.zero?
      self.status_revisao_audio = @revisoes.abertas.size.zero? ? Project::REVISAO_APROVADO : Project::REVISAO_REPROVADO
    puts "------------------audio--------------------------"
    end
    #texto
    @revisoes = reviews.textos
    unless @revisoes.size.zero?
      self.status_revisao_texto = @revisoes.abertas.size.zero? ? Project::REVISAO_APROVADO : Project::REVISAO_REPROVADO
    puts "------------------texto--------------------------"
    end
    #flash
    @revisoes = reviews.flashes
    unless @revisoes.size.zero?
      self.status_revisao_final = @revisoes.abertas.size.zero? ? Project::REVISAO_APROVADO : Project::REVISAO_REPROVADO
    puts "------------------flash--------------------------"
    end
    puts "--------------------------------------------"
    puts self.changes
    puts self.save
    puts self.errors.messages
    puts "--------------------------------------------"
    true
  end
  
  
  after_save do
    self.class.limpar_cached
  end
  
  class << self
    def cached_quantidade_versionadas
      Rails.cache.fetch([:project, :count, :versioned]) { versionadas.count }
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
    
    def cached_group_degree
      Rails.cache.fetch([:project, :count, :versioned, :by_degree]) { versionadas.select('degree_id, count(*)').group(:degree_id).count }
    end
    
    def cached_group_subject
      Rails.cache.fetch([:project, :count, :versioned, :by_subject]) { versionadas.select('subject_id, count(*)').group(:subject_id).count }
    end
    
    
    def limpar_cached
      Rails.cache.delete([:project, :count, :versioned])
      Rails.cache.delete([:project, :count, :versioned, :by_texto])
      Rails.cache.delete([:project, :count, :versioned, :by_audio])
      Rails.cache.delete([:project, :count, :versioned, :by_final])
      Rails.cache.delete([:project, :count, :versioned, :by_degree])
      Rails.cache.delete([:project, :count, :versioned, :by_subject])
    end
  end
end
