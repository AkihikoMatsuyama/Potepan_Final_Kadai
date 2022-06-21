require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { create(:image) }

  background do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  scenario "カテゴリー一覧ページの商品をクリックすると、商品詳細ページに遷移すること" do
    click_on product.name
    expect(page).to have_current_path potepan_product_path(product.id)
  end

  scenario "サイドバーの商品をクリックすると、カテゴリーページに遷移すること" do
    click_link taxon.name
    expect(page).to have_current_path potepan_category_path(taxon.id)
  end

  scenario "サイドバーにカテゴリー名が表示出来ていること" do
    within("ul.side-nav") do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content taxon.name
    end
  end

  scenario "サイドバーの商品数と表示される商品数が同じであること" do
    expect(page.all('.productBox').count).to eq taxon.products.count
  end
end
