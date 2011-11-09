class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :degree
  has_many :animations
  has_many :project_versions
  alias :versions :project_versions
  
  
  belongs_to :user_revisao_texto, :class_name=>'User', :foreign_key => 'user_id_revisao_texto'
  belongs_to :user_revisao_final, :class_name=>'User', :foreign_key => 'user_id_revisao_final'
  include Revisao
  
  AULAS = (1..12).to_a
  
  has_attached_file :capa,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
  validates_presence_of :sequencia
  validates_uniqueness_of :sequencia, :scope => [:subject_id, :degree_id]
  
  after_save do
    self.class.limpar_cached
  end
  
  class << self
    def cached_quantidade_versionadas
      Rails.cache.fetch([:project, :count, :versioned]) { where('project_versions_count > 0').count }
    end
    
    def limpar_cached
      Rails.cache.delete([:project, :count, :versioned])
    end
  end
end
