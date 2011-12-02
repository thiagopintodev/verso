class Degree < ActiveRecord::Base
  include AllCached
  
  has_many :projects
  
  def to_s
    "#{nome}o Ano"
  end
  
  has_attached_file :arquivo,
                    :url  => "/arquivos/sumarios/:id/:filename",
                    :path => ":rails_root/public/arquivos/sumarios/:id/:filename"

end
