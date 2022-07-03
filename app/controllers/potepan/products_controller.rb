class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @category = @product.taxons.first
    @related_products = @product.relation_products.includes(master: [:default_price, :images]).limit(MAX_RELATED_PRODUCTS_COUNT)
  end
end
