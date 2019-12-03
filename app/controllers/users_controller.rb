class UsersController < ApplicationController
  def authenticate
    unless user = User.authenticate(params[:user])
      user = User.create!(params)
    end
    session[:current_user_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
