require 'rails_helper'

describe Cocktail do
  before :each do

    @data = { name: "Damned if you do",
              ingredients:"Whiskey, Hot Damn",
              recipe: "Pour into shot glass. Put in mouth. Repeat as deemed necessary."
            }
    @id = 1

    @cocktail = Cocktail.new(@data, @id)
  end

  it 'exists' do
    expect(@cocktail).to be_a(Cocktail)
  end

  it 'has attributes' do
    expect(@cocktail.name).to eq(@data[:name])
    expect(@cocktail.ingredients).to eq(@data[:ingredients])
    expect(@cocktail.recipe).to eq(@data[:recipe])
    expect(@cocktail.id).to eq(@id)
  end

end
