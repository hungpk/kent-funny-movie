# frozen_string_literal: true

require "exceptions"

class User < ApplicationRecord
  has_secure_password
  has_many :movies
  validates :email, uniqueness: true

  def self.authenticate(user_params)
    user = User.find_by(email: user_params[:email])
    return unless user
    raise ::Exceptions::InvalidPassword, "Invalid Password"  unless user.authenticate(user_params[:password])
    user
  end
end
