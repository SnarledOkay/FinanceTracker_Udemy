module DeviseBootstrapHelper
  def bootstrap_devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |message| content_tag(:li, message) }.join
    sentence = I18n.t(
      "errors.messages.not_saved",
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase
    )

    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show">
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      <h4 class="alert-heading">#{sentence}</h4>
      <ul class="mb-0">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
