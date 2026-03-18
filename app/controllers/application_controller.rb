class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def render_rejection
    render json: { error: I18n.t('auth.errors.invalid_credentials') }, status: :unauthorized
  end

  def redirect_if_authenticated
    redirect_to root_url if signed_in?
  end
end
