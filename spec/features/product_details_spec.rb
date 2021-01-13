require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'


    
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG

    first('a.btn.btn-default').click
    save_screenshot "product_details.png"
    expect(page).to have_content "Apparel"
  end
end