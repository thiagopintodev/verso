class ProjectVersion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  has_attached_file :fla
  has_attached_file :swf1
  has_attached_file :swf2
  has_attached_file :swf3
  has_attached_file :swf4
  
  validates_attachment_presence :fla
  
  validates_attachment_content_type :fla,
                                    :content_type => [ 'application/octet-stream' ],
                                    :message => 'nao indica que este seja um arquivo .FLA'
  validates_attachment_content_type :swf1,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf2,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf3,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
  validates_attachment_content_type :swf4,
                                    :content_type => [ 'application/x-shockwave-flash' ],
                                    :message => 'nao indica que este seja um arquivo .SWF'
end
