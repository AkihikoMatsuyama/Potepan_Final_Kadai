require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon2) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:product) { create(:product, taxons: [taxon, taxon2]) }
  given(:related_product) { create_list(:product, 5, taxons: [taxon, taxon2]) }
  given(:image) { create(:image) }

  background do
    product.images << image
    related_product.each do |rel_product|
      rel_product.images << create(:image)
    end
    visit potepan_product_path(product.id)
  end

  scenario "一覧ページへ戻るをクリックすると、商品が属しているtaxonに遷移すること" do
    click_link "一覧ページへ戻る"
    expect(page).to have_current_path potepan_category_path(taxon.id)
  end

  scenario "関連商品が最大で4つ表示されていること" do
    expect(page.all(".productBox").count).to be_between(1, 4).inclusive
  end

  scenario "関連商品名をクリックすると、関連商品の詳細ページに遷移すること" do
    click_link related_product.first.name
    expect(page).to have_current_path potepan_product_path(related_product.first.id)
  end
end
