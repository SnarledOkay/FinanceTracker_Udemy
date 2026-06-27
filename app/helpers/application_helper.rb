module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice then "alert-success"
    when :alert then "alert-danger"
    when :info then "alert-info"
    when :warning then "alert-warning"
    else "alert-secondary"
    end
  end
end
