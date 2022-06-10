require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "ページタイトル" do
    it "1.トップページのタイトルは、BIGBAG Storeになる" do
      expect(full_title("")).to eq 'BIGBAG Store'
      expect(full_title(nil)).to eq 'BIGBAG Store'
    end

    it "2.商品詳細ページのタイトルは、商品名がテストの場合、テスト - BIGBAG Storeになる" do
      expect(full_title("テスト")).to eq 'テスト - BIGBAG Store'
    end
  end
end
