# frozen_string_literal: true

class Menus::CreateForm < Reform::Form
  property :course
  property :price
  property :name

  validates :name, :price, :course, presence: true
  validate :day_on_weekend

  def save
    return false unless valid?

    super
  end

  private

  def day_on_weekend
    return if Time.zone.now.on_weekday?

    errors[:base] << I18n.t('errors.menus.day_on_weekend')
  end
end
