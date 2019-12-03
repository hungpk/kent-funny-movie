# frozen_string_literal: true

class InvalidYoutubeUrl < StandardError; end
class CreateMovieService
  attr_reader :url, :user_id
  def initialize(url:, user_id:)
    @url = url
    @user_id = user_id
  end

  def call
    raise InvalidYoutubeUrl if video_id.blank?

    Movie.create!(video_id: video_id,
                  user_id: user_id,
                  url: url,
                  description: youtube_video.description,
                  title: youtube_video.title)
  end

  private
    def video_id
      @video_id ||= begin
                      URI(url).query.split("&").find { |x| x.start_with?("v=") }.split("=").last
                    rescue StandardError
                      nil
                    end
    end

    def youtube_video
      @youtube_video ||= Yt::Video.new(id: video_id)
    end
end
