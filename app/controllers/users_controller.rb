# frozen_string_literal: true

class UsersController < ApplicationController
  def authenticate
    unless user = User.authenticate(user_params)
      user = User.create!(user_params)
    end
    session[:current_user_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:current_user_id] = nil
    redirect_to root_path
  end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
