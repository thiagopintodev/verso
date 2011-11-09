module Revisao
  def self.included(base)
    # base == ActiveRecord::Base (the class)
    base.class_eval do
      # class_eval makes self == ActiveRecord::Base, and makes def define instance methods.
           
      def revisao_texto
        return "NAO LIDO" unless self.user_revisao_texto
        ["@#{user_revisao_texto.username}", ARRAY_FOR_SELECT[status_revisao_texto].first]
      end
      def revisao_final
        return "NAO LIDO" unless user_revisao_final
        ["@#{user_revisao_final.username}", ARRAY_FOR_SELECT[status_revisao_final].first]
      end
      
    end
  end
  ARRAY_FOR_SELECT = [['NAO LIDO', 0], ['REPROVADO', 1], ['APROVADO', 2]]
end
