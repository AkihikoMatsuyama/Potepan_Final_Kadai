require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "商品詳細ページ" do
    let(:product) { create(:product) }
    let(:image) { create(:image) }
    let!(:filename) {
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    }

    before do
      product.images << image
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
      expect(response.body).to include product.display_price.to_s
    end

    it "商品画像のファイルが生成されること" do
      expect(response.body).to include filename
    end
  end
end
