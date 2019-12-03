# frozen_string_literal: true

class MoviesController < ApplicationController
  PAGE_SIZE = 20
  before_action :login_required!, except: [:index]
  [
    Yt::Errors::NoItems,
    ActiveRecord::RecordInvalid,
    Exceptions::InvalidYoutubeUrl
  ].each { |err_klass|
    rescue_from(err_klass, with: :show_errors)
  }

  def index
    @movies = Movie.includes(:user).page(current_page).per(PAGE_SIZE)
  end

  def create
    CreateMovieService.new(url: params[:url], user_id: current_user.id).call
    redirect_to root_path, flash: { notice: "Thank you for your sharing" }
  end

  private
    def show_errors(err)
      redirect_to new_movie_path, flash: { error: err.message || "Invalid Youtube URL" }
    end

    def current_page
      @page ||= (params[:page] || 1).to_i
    end
end
