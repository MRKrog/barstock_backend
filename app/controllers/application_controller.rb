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

  def find_business(api_key)
    Business.find_by!(api_key: api_key)
  end
end
