class Review < ActiveRecord::Base
  belongs_to :project
  belongs_to :criou_user,     :class_name=>'User', :foreign_key=>:criou_user_id
  belongs_to :corrigiu_user,  :class_name=>'User', :foreign_key=>:corrigiu_user_id
  belongs_to :revisou_user,   :class_name=>'User', :foreign_key=>:revisou_user_id
  
  validates :project, :presence=>true
  validates :criou_user, :presence=>true
  validates :texto, :length => { :minimum=>2 }
  
  validate do
    if Rails.env.production? && corrigiu? && corrigiu.user_id == revisou.user_id
      errors[:revisou_user_id] = "Voce nao pode revisar sua propria correcao"
    end
  end
  
  TIPO_TEXTO = 0
  TIPO_FLASH = 1
  TIPO_AUDIO = 2
  
  TIPOS_HASH = {
    TIPO_TEXTO=>('ORTOGRAFICA'),
    TIPO_FLASH=>('ANIMACAO'),
    TIPO_AUDIO=>('AUDIO')
  }
  
  TIPOS = [
    [TIPOS_HASH[0], 0],
    [TIPOS_HASH[1], 1],
    [TIPOS_HASH[2], 2]
  ]
  

  scope :abertas,  where(:revisou_aprovou => false)
  
  scope :textos,  where(:tipo => TIPO_TEXTO)
  scope :flashes, where(:tipo => TIPO_FLASH)
  scope :audios,  where(:tipo => TIPO_AUDIO)
  
  def tipo_nome
    TIPOS_HASH[tipo]
  end
  
  def ortografica?
    tipo==TIPO_TEXTO
  end
  def audio?
    tipo==TIPO_AUDIO
  end
  def animacao?
    tipo==TIPO_FLASH
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
      @parent.revisou_aprovou=false
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
  
  def salva_e_recalcula
    save and project.recalcula_revisoes
  end
  
  def cadastrar(user, project_id, tipo, texto)
    self.project_id = project_id
    self.tipo       = tipo
    self.texto      = texto
    criou.at = Time.now
    criou.user = user
    salva_e_recalcula
  end
  
  def cadastrar_aprovada(user, project_id, tipo)
    self.project_id = project_id
    self.tipo       = tipo
    self.texto      = "*** Nao foram encontrados erros ***"
    criou.user    = user
    corrigiu.user = user
    revisou.user  = user
    criou.at    = Time.now
    corrigiu.at = criou.at
    revisou.at  = criou.at
    revisou.aprovou = true
    salva_e_recalcula
  end
  
  def corrigir(user)
    corrigiu.user = user
    corrigiu.at = Time.now
    revisou.clear
    salva_e_recalcula
  end
  
  def revisar(user, bool_aprovado)
    revisou.user = user
    revisou.at = Time.now
    revisou.aprovou = bool_aprovado
    salva_e_recalcula
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
