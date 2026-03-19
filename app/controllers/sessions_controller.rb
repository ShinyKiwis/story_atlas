class SessionsController < ApplicationController
  restore_authenticated_access
  before_action :ensure_user_exists, only: :new
  before_action :redirect_if_authenticated, only: [:new]

  def new
  end
  
  def create
    if @user = User.authenticate_by(username: params[:username], password: params[:password])
      start_new_session_for @user
      render :create, status: :ok
    else
      render_rejection
    end
  end

  def destroy
    reset_authentication
    head :no_content
  end

  private

  def ensure_user_exists
    redirect_to first_run_url if User.none?
  end
end
