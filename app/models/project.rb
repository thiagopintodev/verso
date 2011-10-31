class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :degree
  has_many :animations
  
  has_attached_file :capa
  
  validates_presence_of :sequencia
  validates_uniqueness_of :sequencia, :scope => [:subject_id, :degree_id]
end
