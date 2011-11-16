class Review < ActiveRecord::Base
  belongs_to :project
  belongs_to :criou_user,     :class_name=>'User', :foreign_key=>:criou_user_id
  belongs_to :corrigiu_user,  :class_name=>'User', :foreign_key=>:corrigiu_user_id
  belongs_to :revisou_user,   :class_name=>'User', :foreign_key=>:revisou_user_id
  
  validates :project, :presence => true
  validates :texto, :length => { :minimum=>2 }
  
  TIPO_TEXTO = 0
  TIPO_FLASH = 1
  TIPO_AUDIO = 2
  
  TIPOS_HASH = {
    0=>('ORTOGRAFICA'),
    1=>('ANIMACAO'),
    2=>('AUDIO')
  }
  
  TIPOS = [
    [TIPOS_HASH[0], 0],
    [TIPOS_HASH[1], 1],
    [TIPOS_HASH[2], 2]
  ]
  
  
  
  def tipo_nome
    TIPOS_HASH[tipo]
  end
  
  def ortografica?
    tipo==0
  end
  def audio?
    tipo==1
  end
  def animacao?
    tipo==2
  end
  def corrigiu?
    corrigiu.at.present?
  end
  def revisou?
    revisou.at.present?
  end
  def aprovou?
    revisou.aprovou?
  end
  
  def precisa_revisar?
    corrigiu? and not revisou?
  end
  def precisa_corrigir?
    #!aprovou? || !corrigiu?
    (not corrigiu?) || (revisou? and not aprovou?)
  end
  
  
  class Author
    attr_accessor :parent, :prefix
    
    def initialize(parent, prefix)
      @parent = parent
      @prefix = prefix
    end
    def method_missing(m_name, *args, &block)  
      m = "#{@prefix}_#{m_name}"
      return @parent.send(m) if args.first.nil?
      @parent.send(m, args.first)
    end
    def clear
      @parent.attributes.each do |k, v|
        @parent[k] = nil if k.starts_with? prefix
      end
    end
  end
  
  def criou
    @criou ||= Author.new(self, 'criou')
  end
  def corrigiu
    @corrigiu ||= Author.new(self, 'corrigiu')
  end
  def revisou
    @revisou ||= Author.new(self, 'revisou')
  end
=begin
  def self.author(prefix)
    class_eval do
      attr_reader prefix
      after_initialize do
        instance_variable_set "@#{prefix}", Author.new(self, prefix)
      end
    end
  end
  author :revisou
=end

  validates :project, :presence=>true
  validates :criou_user, :presence=>true
end
=begin
      t.integer :criou_user_id
      t.datetime :criou_created_at
      t.text :criou_texto
      
      t.integer :corrigiu_user_id
      t.datetime :corrigiu_created_at
      t.text :corrigiu_texto
      
      t.integer :revisou_user_id
      t.datetime :revisou_created_at
      t.text :revisou_texto
=end
