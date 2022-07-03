require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon2) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon3) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon4) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:product) { create(:product, taxons: [taxon, taxon2]) }
  given(:product2) { create(:product, taxons: [taxon3, taxon4]) }
  given(:related_products) { create_list(:product, 5, taxons: [taxon, taxon2]) }
  given(:image) { create(:image) }

  background do
    product.images << image
    related_products.each do |rel_product|
      rel_product.images << create(:image)
    end
    visit potepan_product_path(product.id)
  end

  scenario "関連商品が存在しない場合、関連商品のCSSのproductBoxが表示されないこと" do
    visit potepan_product_path(product2.id)
    expect(page.all(".productBox").count).to eq 0
  end

  scenario "一覧ページへ戻るをクリックすると、商品が属しているtaxonに遷移すること" do
    click_link "一覧ページへ戻る"
    expect(page).to have_current_path potepan_category_path(taxon.id)
  end

  scenario "関連商品が最大で4つ表示されていること" do
    expect(page.all(".productBox").count).to be_between(1, 4).inclusive
  end

  scenario "関連商品名をクリックすると、関連商品の詳細ページに遷移すること" do
    click_link related_products.first.name
    expect(page).to have_current_path potepan_product_path(related_products.first.id)
  end
end
