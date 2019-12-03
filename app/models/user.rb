# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :movies

  def self.authenticate(user_params)
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      user
    else
      nil
    end
  end
end
