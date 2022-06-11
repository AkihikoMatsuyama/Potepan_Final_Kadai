require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "商品詳細ページ" do
    let(:product) { create(:product) }

    before do
      get potepan_product_path(product.id)
    end

    it "レスポンスが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "商品名が表示されること" do
      expect(response.body).to include product.name
    end

    it "商品説明文が表示されること" do
      expect(response.body).to include product.description
    end

    it "商品の値段が表示されること（ドルマーク付き）" do
      expect(response.body).to include product.prices.where(currency: "USD").first.money.to_s
    end

    it "商品の画像が表示されること" do
      expect(response.body).to include product.images.last.to_s
    end
  end
end
