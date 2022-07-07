require 'rails_helper'

RSpec.describe Potepan::ProductsDecorator, type: :model do
  describe '商品詳細ページの関連商品の部分' do
    subject { product.relation_products }

    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let!(:product_list) { create_list(:product, 3, taxons: [taxon, taxon2]) }
    let!(:product) { product_list.first }

    it "関連商品に絞り込めていること" do
      expect(subject).not_to include product
    end

    it "関連商品の並び順が名前の照準になっていること" do
      product.name = 'ZET'
      product.reload
      expect(subject).to match subject.order(:name)
    end
  end
end
