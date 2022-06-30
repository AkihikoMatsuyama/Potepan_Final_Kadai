module Potepan::ProductsDecorator
  Spree::Product.prepend self

  def relation_products
    Spree::Product
      .in_taxons(taxons)
      .includes(master: [:default_price, :images])
      .where.not(id: id)
      .distinct
      .order(:name)
  end
end
