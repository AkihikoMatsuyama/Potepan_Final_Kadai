module ApplicationHelper
  Base_title = 'BIGBAG Store'.freeze
  def full_title(page_title)
    page_title.blank? ? Base_title : "#{page_title} - #{Base_title}"
  end
end
