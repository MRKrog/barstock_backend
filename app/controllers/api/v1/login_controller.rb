class Api::V1::LoginController < ApplicationController

  def create
    if
      dis = Distributor.find_by(name: login_params[:credential])
      dis ? do_authentication(dis, login_params[:password]) : error
    else
      bus = Business.find_by(email: login_params[:credential])
      bus ? do_authentication(bus, login_params[:password]) : error
    end
  end

  private

  def login_params
    params.permit(:credential, :password)
  end

  def error
    render json: { error: 'Invalid credentials' }, status: 400
  end

end
