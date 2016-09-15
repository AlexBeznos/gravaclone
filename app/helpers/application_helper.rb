module ApplicationHelper
  def flash_messages
    flash.map do |key, message|
      content_tag :div, message, class: "alert alert-#{flash_name_to_bootstrap(key)}"
    end.join.html_safe
  end

  private

  def flash_name_to_bootstrap(name)
    case name
    when 'error'
      'danger'
    when 'notice'
      'success'
    else
      name
    end
  end
end
