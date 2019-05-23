class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def do_authentication(user, password)
    if user.authenticate(password)
      render json: { api_key: user.api_key }
    else
      render json: { unauth: 'Incorrect Password' }, status: 401
    end
  end

  def get_business(api_key)
    @business ||= Business.find_by!(api_key: api_key)
  end

  def get_distributor(api_key)
    @distributor ||= Distributor.find_by!(api_key: api_key)
  end

  def business_or_distributor?(api_key)
    if Business.find_by(api_key: api_key)
      get_business(api_key)
    else
      get_distributor(api_key)
    end
  end

  def get_distributor_id(api_key)
    user = business_or_distributor?(api_key)
    user.class == Distributor ? user.id : user.distributor_id
  end
end
