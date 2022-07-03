require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon, taxon2]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2]) }

    it "関連商品が重複していないこと" do
      expect(product.relation_products).to eq product.relation_products.uniq
    end

    it "関連商品が自分自身の商品を含まないこと" do
      expect(product.relation_products).not_to include product
    end

    it "関連商品の並び順が名前の昇順になっていること" do
      expect(product.relation_products).to match product.relation_products.order(:name)
    end
  end
end
