require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "商品詳細ページ" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon_list) { create_list(:taxon, 2, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
    let(:product_list) { create_list(:product, 5, taxons: taxon_list) }
    let(:product) { product_list.first }
    let(:image) { create(:image) }
    let(:filename) {
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    }

    before do
      product.images << image
      product_list.each do |rel_product|
        rel_product.images << create(:image)
      end
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

    it "商品画像のファイル名が生成されること" do
      expect(response.body).to include filename
    end

    it "関連商品名が表示されること" do
      expect(css_select(".productBox").text).to include product_list.second.name
    end

    it "関連商品の値段が表示されること（ドルマーク付き）" do
      expect(css_select(".productBox").text).to include product_list.second.display_price.to_s
    end

    it "関連商品の画像が表示されること" do
      expect(css_select(".productBox").inner_html).to include filename
    end
  end
end
