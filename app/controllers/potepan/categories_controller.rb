class Potepan::CategoriesController < ApplicationController
  def show
    @category = Spree::Taxon.find(params[:id])
    # @categories = Spree::Taxon.all
    @taxonomies = Spree::Taxon.roots
  end
end