require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let(:taxon3) { create(:taxon) }
    let(:taxon4) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon, taxon2]) }
    let(:product2) { create(:product, taxons: [taxon3, taxon4]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2]) }
    let!(:related_products2) { create_list(:product, 2, taxons: [taxon3, taxon4]) }

    it "関連商品が重複していないこと" do
      expect(related_products.last.taxons).to eq product.taxons
      expect(related_products2.last.taxons).to eq product2.taxons
      expect(product.relation_products).to eq product.relation_products.uniq
    end

    it "関連商品が自分自身の商品を含まないこと" do
      expect(product.relation_products).not_to include product
      expect(product2.relation_products).not_to include product2
    end

    it "関連商品が最大4つになること" do
      expect(product.relation_products.count).to eq 5
      expect(product.relation_products.limit(4).count).to be_between(1, 4).inclusive
      expect(product2.relation_products.count).to eq 2
      expect(product2.relation_products.limit(4).count).to be_between(1, 4).inclusive
    end
  end
end
