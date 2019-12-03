# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  
  protected
  def current_user
    if session[:current_user_id]
      @current_user ||= User.find(session[:current_user_id]) 
    else
      nil
    end
  end
end
