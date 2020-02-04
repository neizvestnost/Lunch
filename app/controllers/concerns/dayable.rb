# frozen_string_literal: true

module Dayable
  extend ActiveSupport::Concern

  def current_or_default_day
    @day = current_day.on_weekend? ? current_day.monday : current_day
  end

  private

  def current_day
    @current_day ||= Time.zone.today
  end
end
