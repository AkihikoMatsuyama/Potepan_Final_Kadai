require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title(product_name)" do
    subject { helper.full_title(product_name) }

    context "product_nameが空白の場合のページタイトルは、BIGBAG Storeになる" do
      let(:product_name) { '' }
      it { is_expected.to eq 'BIGBAG Store' }
    end

    context "product_nameがnilの場合のページタイトルは、BIGBAG Storeになる" do
      let(:product_name) { nil }
      it { is_expected.to eq 'BIGBAG Store' }
    end

    context "product_nameがテストの場合のページタイトルは、テスト - BIGBAG Storeになる" do
      let(:product_name) { SecureRandom.alphanumeric(8) }
      it { is_expected.to eq "#{product_name} - BIGBAG Store" }
    end
  end
end
