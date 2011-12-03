class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation


  has_many :projects
  has_many :reviews
  
  has_many :criou_reviews,     :class_name=>'Review', :foreign_key=>:criou_user_id
  has_many :corrigiu_reviews,  :class_name=>'Review', :foreign_key=>:corrigiu_user_id
  has_many :revisou_reviews,   :class_name=>'Review', :foreign_key=>:revisou_user_id

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false, :allow_blank => false
  validates_uniqueness_of :email,    :case_sensitive => false, :allow_blank => false
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => false

  def is_revisao?
    is_revisao_texto || is_revisao_audio || is_revisao_final
  end

  def self.find_auto
    find_by_username('auto')
  end
  
  def self.u(username)
    find_by_username(username)
  end

  def u_
    "@#{username}"
  end





  # login can be either username or email address
  def self.authenticate(login, pass)
    return nil unless login && pass
    user = if login.include?('@') then where('lower(email) = ?',    login.downcase).first
                                  else where('lower(username) = ?', login.downcase).first
                                  end
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
