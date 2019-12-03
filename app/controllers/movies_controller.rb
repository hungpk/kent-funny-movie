# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :login_required!, except: [:index]
  [
    InvalidYoutubeUrl,
    Yt::Errors::NoItems,
    ActiveRecord::RecordInvalid
  ].each do |err|
    rescue_from err, with: :show_errors
  end
      
  def index
    @movies = Movie.includes(:user).all
  end

  def create
    CreateMovieService.new(url: params[:url], user_id: current_user.id).call
    redirect_to root_path, flash: {notice: 'Thank you for your sharing'}
  end

  private
    def show_errors (err)
      redirect_to new_movie_path, flash: {error: err.message || 'Invalid Youtube URL'}
    end
end
