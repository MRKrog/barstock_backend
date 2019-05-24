require 'rails_helper'

describe BusinessAccount do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
    @business_account = BusinessAccount.new(@business, @distributor, @rep)
  end

  it 'exists' do
    expect(@business_account).to be_a(BusinessAccount)
  end

  it 'has attributes' do
    expect(@business_account.address).to eq(@business.address)
    expect(@business_account.distributor[:distributor_address]).to eq(@distributor.address)
    expect(@business_account.distributor[:distributor_name]).to eq(@distributor.name)
    expect(@business_account.email).to eq(@business.email)
    expect(@business_account.name).to eq(@business.name)
    expect(@business_account.phone_number).to eq(@business.phone_number)
    expect(@business_account.rep[:rep_email]).to eq(@rep.email)
    expect(@business_account.rep[:rep_name]).to eq(@rep.name) 
    expect(@business_account.rep[:rep_phone_number]).to eq(@rep.phone_number)
  end

end
