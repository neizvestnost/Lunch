# frozen_string_literal: true

class ApplicationService
  include Pagy::Backend
  extend SmartInit

  is_callable
end
