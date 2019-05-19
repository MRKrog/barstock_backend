require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :alc_type }
    it { should validate_presence_of :alc_category }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :ounces }
    it { should validate_numericality_of(:ounces).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :unit }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end

  describe 'relationships' do
    it { should belong_to :distributor }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
    it { should have_many :business_items }
    it { should have_many(:business).through(:business_items) }
  end

  describe 'class methods' do
    it '#distributor_items' do

      distributor_1 = Distributor.create!(name: "RNDC",
                                        address: "3319 Arapahoe st, Denver, CO",
                                        distributor_code: "CODE1234",
                                        api_key: "jgn983hy48thw9begh98h4539h4",
                                        password: "password"
                                        )
      distributor_2 = Distributor.create!(name: "Other",
                                        address: "other",
                                        distributor_code: "other",
                                        api_key: "other",
                                        password: "other"
                                        )

      item_1 = create(:item, distributor: distributor_1)
      item_2 = create(:item, distributor: distributor_1)
      create(:item, distributor: distributor_2)

      items = Item.distributor_items(distributor_1.id)

      expect(items.count).to eq(2)
      expect(items[0]).to be_an_instance_of(Item)
      expect(items[1]).to be_an_instance_of(Item)
      expect(items[0].id).to eq(item_1.id)
      expect(items[1].id).to eq(item_2.id)
      expect(items[0].distributor_id).to eq(distributor_1.id)
      expect(items[1].distributor_id).to eq(distributor_1.id)
    end
  end
end
