require 'rails_helper'

describe 'User visits the root page' do
# feature 'User visits the root page' do
  # scenario 'they see user interface gifs' do
  #   visit root_path
  #
  #   expect(page).to have_content('Login Screen')
  #   expect(page).to have_content('Selecting Inventory')
  #   expect(page).to have_content('View Margin/Profits')
  #   expect(page).to have_content('Place Order')
  #   expect(page).to have_content('Account Information')
  #   expect(page).to have_content('Reorder')
  #
  #   # expect(page).to have_xpath("//img[contains(@src,'accountinfo.gif')]")
  # end

  it 'they see a link to Swagger and a Swagger gif' do
    visit root_path

    expect(page).to have_content("Swagger")
  end
end
