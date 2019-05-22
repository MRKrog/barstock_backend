require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_numericality_of(:phone_number).only_integer }
    it { should validate_numericality_of(:phone_number).is_greater_than_or_equal_to(1) }
  end

  describe 'relationships' do
    it { should belong_to :distributor }
    it { should have_many :businesses }
  end
end
