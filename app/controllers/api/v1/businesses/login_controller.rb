class Api::V1::Businesses::LoginController < ApplicationController

  def create
    business = Business.find_by!(email: login_params[:email])
    if business.authenticate(login_params[:password])
      render json: { api_key: business.api_key }
    else
      render json: { unauth: 'Incorrect Password' }, status: 401
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

end
