module Api::UserAuthenticator
  extend ActiveSupport::Concern

  def current_user
    return @_current_user if @_current_user
    return unless bearer_token

    payload, = User.decode bearer_token
    @_current_user ||= User.find_by(id: payload['user_id'])
  end

  def authenticate!
    return if current_user

    render head: :unauthorized
  end

  def bearer_token
    pattern = /^Bearer /
    header = request.headers['Authorization']

    header.gsub(pattern, '') if header&.match(pattern)
  end
end
