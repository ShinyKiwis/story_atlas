class UsersController < ApplicationController
  require_authenticated_access

  def me
    @user = Current.user
  end
end
