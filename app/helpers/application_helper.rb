module ApplicationHelper

  def swf(url)
    raw "<object width='200' height='150'
classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000'
codebase='http://fpdownload.macromedia.com/
pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0'>
<param name='SRC' value='#{url}'>
<embed src='#{url}' width='200' height='150'></embed>
</object>"
  end

end
