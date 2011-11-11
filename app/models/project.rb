class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :degree
  has_many :animations
  has_many :project_versions
  alias :versions :project_versions
  
  scope :versionadas, where('project_versions_count > 0')
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_audio, :class_name=>'User', :foreign_key => 'user_id_revisao_audio'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  include Revisao
  
  AULAS = (1..12).to_a
  
  has_attached_file :capa,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
  validates_presence_of :numero
  validates_uniqueness_of :numero, :scope => [:subject_id, :degree_id]
  
  def nome
    "#{numero}a Aula"
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
