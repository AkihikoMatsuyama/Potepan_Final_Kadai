module Potepan::ProductsDecorator
  Spree::Product.prepend self

  def relation_products
    Spree::Product.in_taxons(taxons).distinct.where.not(id: id)
  end
end
