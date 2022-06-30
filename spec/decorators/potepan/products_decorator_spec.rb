require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    let!(:taxon) { create(:taxon) }
    let!(:taxon2) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon, taxon2]) }
    let!(:related_product) { create(:product, taxons: [taxon, taxon2]) }

    it "関連商品が重複していないこと" do
      expect(related_product.taxons).to eq product.taxons
      expect(product.relation_products).to eq product.relation_products.uniq
    end

    it "関連商品が自分自身の商品を含まないこと" do
      expect(product.relation_products).not_to contain_exactly(product)
    end
  end
end
