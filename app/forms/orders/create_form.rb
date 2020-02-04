# frozen_string_literal: true

class Orders::CreateForm < Reform::Form
  property :main_dish_id
  property :appetizer_dish_id
  property :drink_dish_id
  property :blank, virtual: true

  validate :date_on_weekend, :order_blank

  def save
    return false unless valid?

    super.tap { CalcTotalCostService.call(order: model) }
  end

  private

  def date_on_weekend
    return if Time.zone.now.on_weekday?

    errors[:base] << I18n.t('errors.orders.day_on_weekend')
  end

  def order_blank
    return if @fields['blank'] != 'true'

    errors[:base] << I18n.t('errors.orders.blank')
  end
end
