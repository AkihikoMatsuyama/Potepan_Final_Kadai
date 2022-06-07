require 'rails_helper'

RSpec.describe "Potepan::Samples", type: :request do
  describe "GET /potepan/index" do
    it "正常にレスポンスを返すこと" do
      get "/potepan/index"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /potepan/products/id" do
    let(:product) { create(:product) }

    it "正常にレスポンスを返すこと（商品詳細）" do
      get potepan_product_shousai_path(product.id)
      expect(response).to have_http_status(200)
    end
  end
end
