class ApiController < ActionController::Base
 skip_forgery_protection
 include DeviseTokenAuth::Concerns::SetUserByToken

  def authorize_user(resource)
    unless resource.user == current_user
       render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
    end
  end
end
