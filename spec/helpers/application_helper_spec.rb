require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "ページタイトル" do
    it "トップページのタイトルは、BIGBAG Storeになる" do
      expect(full_title("")).to eq 'BIGBAG Store'
      expect(full_title(nil)).to eq 'BIGBAG Store'
    end

    product_name = SecureRandom.alphanumeric(8)
    it "商品詳細ページのタイトルは、商品名が#{product_name}の場合、#{product_name} - BIGBAG Storeになる" do
      expect(full_title(product_name)).to eq("#{product_name} - BIGBAG Store")
    end
  end
end
