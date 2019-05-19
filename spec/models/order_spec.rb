require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of :total_cost }
    it { should validate_numericality_of(:total_cost).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :business }
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end
end
