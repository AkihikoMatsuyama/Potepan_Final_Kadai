class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_MAX_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @category = @product.taxons.first
    @related_products = @product.relation_products.limit!(RELATED_PRODUCTS_MAX_COUNT)
  end
end
