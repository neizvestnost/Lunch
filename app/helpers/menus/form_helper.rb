# frozen_string_literal: true

module Menus::FormHelper
  def menu_for(menu:, form:, name:)
    form.input(
      name,
      label: false,
      collection: menu.map { |el| [[el.name, el.price].join('---'), el.id] }
    )
  end
end
