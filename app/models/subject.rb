class Subject < ActiveRecord::Base
  include AllCached
  
  has_many :projects
end
