require 'rails_helper'

RSpec.feature "Potepan::Products", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon_list) { create_list(:taxon, 2, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon_list2) { create_list(:taxon, 2, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:taxon_list3) { create_list(:taxon, 2, taxonomy: taxonomy, parent_id: taxonomy.root.id) }
  given(:product) { create(:product, taxons: taxon_list) }
  given(:product2) { create(:product, taxons: taxon_list2) }
  given(:product3) { create(:product, taxons: taxon_list3) }
  given(:related_products) { create_list(:product, 5, taxons: taxon_list) }
  given(:related_products_one_image) { create_list(:product, 2, taxons: taxon_list3) }
  given(:image) { create(:image) }

  feature "商品と関連商品が存在している場合" do
    background do
      product.images << image
      related_products.each do |rel_product|
        rel_product.images << create(:image)
      end
      visit potepan_product_path(product.id)
    end

    scenario "商品名が表示されていること" do
      expect(page).to have_selector 'h2', text: product.name
    end

    scenario "商品の価格が表示されていること" do
      expect(page).to have_selector 'h3', text: product.display_price
    end

    scenario "関連商品が最大で4つ表示されていること" do
      expect(page.all(".productBox").count).to eq 4
    end

    scenario "関連商品名が表示されていること" do
      expect(page).to have_selector 'h5', text: related_products.first.name
    end

    scenario "関連商品の価格が表示されていること" do
      expect(page).to have_selector 'h3', text: related_products.first.display_price
    end

    scenario "関連商品名をクリックすると、関連商品の詳細ページに遷移すること" do
      click_link related_products.first.name
      expect(page).to have_current_path potepan_product_path(related_products.first.id)
    end

    scenario "一覧ページへ戻るをクリックすると、商品が属しているtaxonに遷移すること" do
      click_link "一覧ページへ戻る"
      expect(page).to have_current_path potepan_category_path(taxon_list.first.id)
    end
  end

  feature "関連商品が存在しない場合" do
    scenario "関連商品のCSSのproductBoxが表示されないこと" do
      visit potepan_product_path(product2.id)
      expect(page.all(".productBox").count).to eq 0
    end
  end

  feature "関連関連の画像が未登録の場合" do
    background do
      related_products_one_image.first.images << create(:image)
    end

    scenario "products-01.jpgが表示されること" do
      visit potepan_product_path(product3.id)
      expect(page).to have_selector("img[src^='/assets/img/products/products-01']")
    end
  end
end
