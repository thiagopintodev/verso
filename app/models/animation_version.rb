class AnimationVersion < ActiveRecord::Base
  belongs_to :user
  belongs_to :animation
  
  has_attached_file :fla
  has_attached_file :swf
  
  validates_attachment_presence :fla
  validates_attachment_presence :swf
  validates_attachment_content_type :fla,
                                    :content_type => [ 'application/octet-stream' ],
                                    :message => 'nao indica que este seja um arquivo .FLA'
  validates_attachment_content_type :swf,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'

end
