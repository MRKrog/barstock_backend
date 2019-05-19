class Api::V1::Businesses::LoginController < ApplicationController

  def create
    business = Business.find_by!(email: login_params[:email])
    do_authentication(business, login_params[:password])
  end

  private

  def login_params
    params.permit(:email, :password)
  end

end
