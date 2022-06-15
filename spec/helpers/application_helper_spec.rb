require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title(product_name)" do
    subject { helper.full_title(product_name) }

    context "product_nameが空白の場合" do
      let(:product_name) { '' }

      it "BIGBAG Storeになる" do
        is_expected.to eq 'BIGBAG Store'
      end
    end

    context "product_nameがnilの場合" do
      let(:product_name) { nil }

      it "BIGBAG Storeになる" do
        is_expected.to eq 'BIGBAG Store'
      end
    end

    context "product_nameがテストの場合" do
      let(:product_name) { 'テスト' }

      it "テスト - BIGBAG Storeになる" do
        is_expected.to eq "#{product_name} - BIGBAG Store"
      end
    end
  end
end
