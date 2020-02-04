# frozen_string_literal: true

class Pagination::Pagy::PaginationService < ApplicationService
  initialize_with :orders, :page, :request

  def call
    @pagy, @orders = pagy(orders, items: 5)
    build_object
  end

  private

  def pagy_get_vars(collection, vars)
    { count: collection.count(:all),
      page: page }.merge!(vars)
  end

  def build_object
    data = pagy_metadata(@pagy)

    {
      pagy: @pagy,
      paginated_orders: @orders,
      orders_metadata: {
        prev_url: data[:prev_url],
        prev: data[:prev],
        next: data[:next],
        next_url: data[:next_url],
        scaffold_url: data[:scaffold_url],
        series: data[:series]
      }
    }
  end
end
