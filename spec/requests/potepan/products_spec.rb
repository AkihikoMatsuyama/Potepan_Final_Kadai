require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /potepan/products/id" do
    let(:product) { create(:product) }

    before do
      get potepan_product_shousai_path(product.id)
    end

    it "1.正常なレスポンスかどうか？（id取得）" do
      expect(response).to be_successful
    end

    it "2.正常にレスポンスの場合、200（ok）を返すこと" do
      expect(response).to have_http_status(200)
    end

    it "3.商品名が表示されること" do
      expect(response.body).to include product.name
    end

    it "4.商品説明文が表示されること" do
      expect(response.body).to include product.description
    end

    it "5.商品の値段が表示されること" do
      expect(response.body).to include product.price.to_s
    end

    it "6.商品の値段が表示されること（ドル表記：１番目）" do
      expect(response.body).to include product.prices.where(currency: "USD").first.amount.to_s
    end

    it "7.商品の画像が表示されること" do
      expect(response.body).to include product.variant_images.last.to_s
    end
  end
end
