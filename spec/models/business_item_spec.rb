require 'rails_helper'

RSpec.describe BusinessItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :price_sold }
    it { should validate_numericality_of(:price_sold).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :serving_size }
    it { should validate_numericality_of(:serving_size).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :business }
    it { should belong_to :item }
  end
end
