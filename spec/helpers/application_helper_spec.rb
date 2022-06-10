require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "ページタイトル" do
    it "1.トップページのタイトルは、BIGBAG Storeになる" do
      expect(full_title("")).to eq 'BIGBAG Store'
    end

    page_title = 'テスト'.freeze
    base_title = 'BIGBAG Store'.freeze
    it "2.商品詳細のタイトルは、タイトル - BIGBAG Storeになる" do
      expect(full_title(page_title)).to eq("#{page_title} - #{base_title}")
    end
  end
end
