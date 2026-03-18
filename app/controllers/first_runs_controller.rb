class FirstRunsController < ApplicationController
  restore_authenticated_access
  before_action :redirect_if_authenticated, only: [:new]

  def new
  end

  def create
    user = User.create!(user_params)
    start_new_session_for user

    head :created
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end

