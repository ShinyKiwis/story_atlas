class FirstRunsController < ApplicationController

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

