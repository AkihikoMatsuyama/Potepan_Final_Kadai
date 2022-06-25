class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxon.roots
    @products = @taxon.all_products.includes(:variant_images, master: :default_price)
  end
end
