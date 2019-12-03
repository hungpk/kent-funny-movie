# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :login_required!, except: [:index]
  rescue_from Yt::Errors::NoItems, InvalidYoutubeUrl, with: :show_errors
  rescue_from InvalidYoutubeUrl, with: :show_errors
    
  def index
    @movies = Movie.includes(:user).all
  end

  def create
    CreateMovieService.new(url: params[:url], user_id: current_user.id).call
    redirect_to root_path, flash: {notice: 'Thank you for your sharing'}
  end
  
  private
    def show_errors
      redirect_to new_movie_path, flash: {error: 'Invalid Youtube URL'}
    end
end
