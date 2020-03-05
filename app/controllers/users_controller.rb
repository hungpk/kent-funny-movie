# frozen_string_literal: true

class UsersController < ApplicationController
  rescue_from Exceptions::InvalidPassword, with: :show_errors

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
    def show_errors(err)
      redirect_to root_path, flash: { error: "Invalid Youtube URL" }
    end
end
