class Degree < ActiveRecord::Base
  include AllCached
  
  def to_s
    "#{nome}o Ano"
  end
  

end
