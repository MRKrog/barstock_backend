class Api::V1::BusinessesController < ApplicationController

  def create
    business = Business.create_new(business_params, code_params[:distributor_code])
    business.save!
    render json: { api_key: business.api_key }, status: 201
  end

  private

  def business_params
    params.permit(:name, :address, :email, :password, :phone_number)
  end

  def code_params
    params.permit(:distributor_code)
  end

end
