require 'rails_helper'

describe CocktailFacade do
  before :each do
    @ingredient = 'Vodka'
    @facade = CocktailFacade.new(@ingredient, 1)
  end

  it 'exists' do
    expect(@facade).to be_a(CocktailFacade)
  end


  describe 'instance methods' do
    it '#get_cocktail' do
      VCR.use_cassette('get_cocktail', :record => :new_episodes) do
        cocktail = @facade.get_cocktail
        expect(cocktail).to be_a(Cocktail)
        expect(cocktail).to have_attributes(ingredients: String)
        expect(cocktail).to have_attributes(id: Integer)
        expect(cocktail).to have_attributes(name: String)
        expect(cocktail).to have_attributes(recipe: String)
      end
    end

    it '#create_data' do
      VCR.use_cassette('get_data', :record => :new_episodes) do
        data = @facade.create_data
        expect(data).to be_a(Hash)
        expect(data[:name]).to be_a(String)
        expect(data[:ingredients]).to be_a(String)
        expect(data[:recipe]).to be_a(String)
      end
    end

  end

end
