require 'rails_helper'

RSpec.describe Distributor, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
    it { should validate_presence_of :address }
    it { should validate_presence_of :code }
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }
    it { should validate_presence_of :password }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :representatives }
    it { should have_many :businesses }
  end
end
