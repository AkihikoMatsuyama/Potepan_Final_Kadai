require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "カテゴリ一の一覧ページ" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let(:filename) {
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    }

    before do
      product.images << image
      get potepan_category_path(taxon.id)
    end

    it "レスポンスが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "taxonomy名が表示されること" do
      expect(response.body).to include taxonomy.name
    end

    it "taxon名が表示されること" do
      expect(response.body).to include taxon.name
    end

    it "商品の値段が表示されること（ドルマーク付き）" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品画像のファイル名が生成されること" do
      expect(response.body).to include filename
    end
  end
end
