class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def render_rejection
    render json: { error: 'Invalid username or password' }, status: :unauthorized
  end
end
