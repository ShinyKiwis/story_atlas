module Authentication
  extend ActiveSupport::Concern
  include SessionLookup
  included do
    def signed_in?
      Current.user.present?
    end
  end

  class_methods do
    def require_authenticated_access
      before_action :require_authentication
    end

    def restore_authenticated_access
      before_action :restore_authentication
    end
  end

  private

  def require_authentication
    restore_authentication || request_authentication
  end

  def restore_authentication
    if session = find_session_by_cookie
      resume_session session
    end
  end

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to login_url
  end

  def reset_authentication
    cookies.delete(:session_token)
  end

  def resume_session(session)
    session.resume user_agent: request.user_agent, ip_address: request.remote_ip
    authenticated_as session
  end

  def start_new_session_for(user)
    user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
      authenticated_as session
    end
  end

  def authenticated_as(session)
    unless cookies.signed[:session_token]
      cookies.signed.permanent[:session_token] = {
        value: session.token,
        expires: 1.month.from_now,
        httponly: true,
        same_site: :strict
      }
    end
    Current.user = session.user
  end
end
