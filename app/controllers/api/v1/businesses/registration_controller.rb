class Api::V1::Businesses::RegistrationController < ApplicationController

  def create
    business = Business.create_new(business_params, code_rep_params)
    business.save!
    render json: { api_key: business.api_key }, status: 201
  end

  private

  def business_params
    params.permit(:name, :address, :email, :password, :phone_number)
  end

  def code_rep_params
    params.permit(:distributor_code, :rep)
  end

end
