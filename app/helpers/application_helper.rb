module ApplicationHelper

  def set_page_css(val)
    content_for :page_css, val
  end

end
