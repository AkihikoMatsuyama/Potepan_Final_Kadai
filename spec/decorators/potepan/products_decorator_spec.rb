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
  end
end
