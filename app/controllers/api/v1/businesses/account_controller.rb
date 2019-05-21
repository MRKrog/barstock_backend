class Api::V1::Businesses::AccountController < ApplicationController

  def show
    business = get_business(account_params[:api_key])
    bus = BusinessAccount.new(business)
    dis = BusinessDistributor.new(business.distributor)
    rep = BusinessRepresentative.new(business.representative)
    render json: {
                  business: BusinessSerializer.new(bus),
                  distributor: DistributorSerializer.new(dis),
                  rep: RepresentativeSerializer.new(rep)
                 }
  end

  private

  def account_params
    params.permit(:api_key)
  end

end
