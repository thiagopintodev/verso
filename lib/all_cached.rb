module AllCached
  def self.included(base)
    # base == ActiveRecord::Base (the class)
    base.class_eval do
      # class_eval makes self == ActiveRecord::Base, and makes def define instance methods.
      
      after_save do
        Rails.cache.delete(self.class.name)
      end
      
      class << self
        def all_cached
          Rails.cache.fetch(name) { all }
        end
      end
      
    end
  end
end
