class ApplicationController < ActionController::API

  def find_business(api_key)
    business = Business.find_by(api_key: api_key)
    if business == nil
      false
    else
      business
    end
  end

  def unauthorized
    render json: {}, status: 401
  end
end
