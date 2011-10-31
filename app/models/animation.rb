class Animation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :animation_versions
  alias :versions :animation_versions
  
  AULAS = (1..12).to_a
end
