require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "カテゴリ一の一覧ページ" do
    let(:taxonomy) { create(:taxonomy, name: "Categories") }
    let!(:taxonomy2) { create(:taxonomy, name: "Drinks") }
    let(:taxon) { create(:taxon, name: 'Hoodie', taxonomy: taxonomy) }
    let!(:taxon2) { create(:taxon, name: 'Milk', taxonomy: taxonomy2) }
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

    it "Categoriesが表示されていること" do
      expect(response.body).to include taxonomy.name
    end

    it "Drinksが表示されていること" do
      expect(response.body).to include taxonomy2.name
    end

    it "Hoodieが表示されていること" do
      expect(response.body).to include taxon.name
    end

    it "Milkが表示されていること" do
      expect(response.body).to include taxon2.name
    end

    it "商品の値段が表示されること（ドルマーク付き）" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品画像のファイル名が生成されること" do
      expect(response.body).to include filename
    end
  end
end
