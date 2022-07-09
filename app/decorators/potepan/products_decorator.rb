module Potepan::ProductsDecorator
  Spree::Product.prepend self

  def relation_products
    Spree::Product.
      in_taxons(taxons).
      where.not(id: id).
      distinct
  end
end
