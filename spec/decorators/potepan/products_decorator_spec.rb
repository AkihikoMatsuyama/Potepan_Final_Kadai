require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    subject { product.relation_products }

    let(:taxon_list) { create_list(:taxon, 2) }
    let(:product_list) { create_list(:product, 3, taxons: taxon_list) }
    let(:product) { product_list.first }

    it "関連商品に絞り込めていること" do
      expect(subject).not_to include product
    end

    it "in_taxons実行前は、関連商品の数は6になっていること" do
      expect(subject.unscoped.in_taxons(taxon_list).count).to eq 6
    end

    it "distinct実行前は、関連商品が重複していないこと" do
      expect(subject.unscoped.distinct).to eq product_list
    end
  end
end
