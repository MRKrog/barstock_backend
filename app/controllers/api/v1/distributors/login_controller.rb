class Api::V1::Distributors::LoginController < ApplicationController

  def create
    distributor = Distributor.find_by!(name: login_params[:name])
    do_authentication(distributor, login_params[:password])
  end

  private

  def login_params
    params.permit(:name, :password)
  end

end
