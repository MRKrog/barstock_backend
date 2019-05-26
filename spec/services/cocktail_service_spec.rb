require 'rails_helper'

describe CocktailService do
  before :each do
    @service = CocktailService.new
    @ingredient = "Vodka"
  end

  it 'exists' do
    expect(@service).to be_a(CocktailService)
  end

  it 'can get cocktail recipe' do
    json_response = File.open('./fixtures/cocktail.json')
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=Moscow Mule"

    mock = stub_request(:get, url)
        .to_return(status: 200, body: json_response)
    result = JSON.parse(mock.response.body, symbolize_names: true)
    expect(result).to be_a(Hash)
    expect(result[:strIngredient1]).to eq("Vodka")
    expect(result[:strInstructions]).to eq("Combine vodka and ginger beer in a highball glass filled with ice. Add lime juice. Stir gently. Garnish.")
  end

end
