module WithAccessibleHelp

  def label(wrapper_options = nil)
    text = super
    text += " <span class=\"required label label-info\">(required)</span>".html_safe if required_field?
    text
  end

  def hint(wrapper_options = nil)
    text = translate_from_namespace(:metadata_help)
    return unless text
    text
  end

end