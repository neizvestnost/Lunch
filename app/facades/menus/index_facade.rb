# frozen_string_literal: true

class Menus::IndexFacade
  COURSES = %w[main appetizer drink].freeze
  WEEKDAYS = 5

  def initialize(day:)
    @day = day
  end

  def new_order
    Order.new
  end

  # def main_menu
  # def appetizer_menu
  # def drink_menu
  COURSES.each do |course|
    define_method("#{course}_menu") do
      Menu.where(
        "created_at >= '#{day_parse.beginning_of_day}'
        AND created_at <= '#{day_parse.end_of_day}'
        AND course = :course",
        course: course
      )
    end
  end

  private

  def day_parse
    @parsed_day ||= @day.is_a?(String) ? Time.parse(@day) : @day
  end
end
