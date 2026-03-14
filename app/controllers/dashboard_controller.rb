class DashboardController < ApplicationController
  require_authenticated_access

  before_action :ensure_index_is_not_empty, only: [:index]

  def index
  end

  private

  def ensure_index_is_not_empty
    redirect_to login_url if !signed_in?
  end
end
