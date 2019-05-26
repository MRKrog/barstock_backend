require 'rails_helper'

describe CocktailFacade do
  before :each do
    @ingredient = 'Vodka'
    @facade = CocktailFacade.new(@ingredient, 1)
  end

  it 'exists' do
    expect(@facade).to be_a(CocktailFacade)
  end

end
