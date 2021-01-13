require 'rails_helper'

RSpec.feature "Add To Cart", type: :feature, js: true do

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

  scenario "They add a product to their cart" do
    # ACT
    visit root_path

    # DEBUG
    first('a.btn.btn-default').click
    save_screenshot "add_to_cart.png"
    expect(page).to have_content "My Cart (1)"
  end
end