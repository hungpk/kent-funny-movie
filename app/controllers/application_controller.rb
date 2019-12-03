# frozen_string_literal: true

require "exceptions"
class ApplicationController < ActionController::Base
  helper_method :current_user

  protected
    def login_required!
      redirect_to root_path, flash: { error: "Please sign in." } unless current_user
    end

    def current_user
      if session[:current_user_id]
        @current_user ||= User.find(session[:current_user_id])
      else
        nil
      end
    end
end
