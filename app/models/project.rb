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
  
  
end
