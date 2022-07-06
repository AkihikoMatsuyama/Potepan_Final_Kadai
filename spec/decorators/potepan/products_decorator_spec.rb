require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon, taxon2]) }
    let!(:related_products) { create_list(:product, 2, taxons: [taxon, taxon2]) }

    it "関連商品が重複していないこと" do
      expect(related_products).to eq related_products.uniq
      expect(product.relation_products).to eq related_products.uniq
    end

    it "関連商品に絞り込めていること" do
      expect(Spree::Product.in_taxons(product.taxons).count).to eq 6
      expect(Spree::Product.in_taxons(product.taxons).where.not(id: product.id)).
        not_to include product
      expect(Spree::Product.in_taxons(product.taxons).where.not(id: product.id).distinct).
        to eq related_products
      expect(product.relation_products).to eq related_products
    end

    it "関連商品が自分自身の商品を含まないこと" do
      expect(product.relation_products).not_to include product
    end

    it "関連商品の並び順が名前の昇順になっていること" do
      expect(product.relation_products).to match product.relation_products.order(:name)
    end
  end
end
