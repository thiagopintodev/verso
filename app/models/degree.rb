class Degree < ActiveRecord::Base
  include AllCached
  
  has_many :projects
  
  def to_s
    "#{nome}o Ano"
  end
  

end
