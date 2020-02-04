# frozen_string_literal: true

module SharedHelper
  def day_name_link(iterator:, klass: 'nav-item nav-link')
    link_to(
      (Time.zone.today.monday + iterator).strftime('%A, %e/%-m/%Y'),
      { day: (Time.zone.today.monday + iterator) },
      class: klass,
      data: { day: iterator + 1 }
    )
  end
end
