class SessionsController < ApplicationController
  before_action :ensure_user_exists, only: :new
  
  def create
  end

  private

  def ensure_user_exists
    redirect_to first_run_url if User.none?
  end
end
