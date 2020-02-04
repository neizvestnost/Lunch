# frozen_string_literal: true

module HeaderHelper
  def header(header_text:, color:, button_text: nil, button_path: nil)
    render(
      'shared/header/header',
      header_text: header_text,
      color: color,
      button_text: button_text,
      button_path: button_path
    )
  end
end
