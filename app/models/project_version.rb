class ProjectVersion < ActiveRecord::Base
  belongs_to :project, :counter_cache=>true
  belongs_to :user
  
  has_attached_file :fla,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf1,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf2,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf3,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  has_attached_file :swf4,
                    :url  => "/arquivos/:class_:attachment/:id/:filename",
                    :path => ":rails_root/public/arquivos/:class_:attachment/:id/:filename"
  
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
