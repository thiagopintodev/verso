# encoding: UTF-8
module Revisao
  def self.included(base)
    # base == ActiveRecord::Base (the class)
    base.class_eval do
      # class_eval makes self == ActiveRecord::Base, and makes def define instance methods.
           
      def revisao_texto
        return "NAO REVISADO" unless self.user_revisao_texto
        ["@#{user_revisao_texto.username}", ARRAY_FOR_SELECT[status_revisao_texto].first]
      end
      def revisao_final
        return "NAO REVISADO" unless user_revisao_final
        ["@#{user_revisao_final.username}", ARRAY_FOR_SELECT[status_revisao_final].first]
      end
      def revisao_audio
        return "NAO REVISADO" unless user_revisao_audio
        ["@#{user_revisao_audio.username}", AUDIO_FOR_SELECT[status_revisao_audio].first]
      end
      
    end
  end
  ARRAY_FOR_SELECT = Project::REVISOES
  AUDIO_FOR_SELECT = Project::REVISOES
  #AUDIO_FOR_SELECT = [['SEM REVISÃO', 0], ['AUDIO OK', 1],  ['AULA ERRADA', 2], ['DIFERENTE DO ROTEIRO', 3]]
end
