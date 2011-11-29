module ProjectVersionsHelper

  def myfile(img_html, paperclip, url=nil)
    return unless paperclip.present?
    url ||= paperclip.url
    content_tag :tr do
      content_tag :td do
        link_to raw("#{img_html} #{paperclip.original_filename} (#{number_to_human_size(paperclip.size)})"), url, :target=>'_blank'
      end
    end
  end
  
  def myupload(form, field, img_html, texto)
    label_tag do
      raw "#{img_html} #{texto} <br /> #{form.file_field field}"
    end
  end

end
