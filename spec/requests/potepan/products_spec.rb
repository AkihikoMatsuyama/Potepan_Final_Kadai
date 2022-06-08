require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /potepan/products/id" do
    let(:product) { create(:product) }

    it "正常にレスポンスを返すこと（商品詳細）" do
      get potepan_product_shousai_path(product.id)
      expect(response).to have_http_status(200)
    end
  end
end
