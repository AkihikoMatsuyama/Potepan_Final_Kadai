require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '#relation_products' do
    subject { product.relation_products }

    let(:taxon_list) { create_list(:taxon, 2) }
    let(:product_list) { create_list(:product, 3, taxons: taxon_list) }
    let(:product) { product_list.first }

    it "関連商品に絞り込めていること" do
      expect(subject).to match_array [product_list.second, product_list.third]
    end
  end
end
