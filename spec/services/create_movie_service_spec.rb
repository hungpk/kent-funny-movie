# frozen_string_literal: true

require "rails_helper"
require "exceptions"

RSpec.describe CreateMovieService, type: :model do
  let(:user) { create(:user) }
  context "with invalid URL" do
    let(:youtube_url) { "https://youtube.com" }
    it "raise error InvalidYoutubeUrl" do
      expect do
        CreateMovieService.new(url: youtube_url, user_id: user.id).call
      end.to raise_error(Exceptions::InvalidYoutubeUrl)
    end
  end
  context "with valid URL" do
    let(:youtube_video_id) { "a-video-id" }
    let(:youtube_url) { "https://youtube.com?v=#{youtube_video_id}" }
    let(:service) { CreateMovieService.new(url: youtube_url, user_id: user.id) }
    let(:youtube_video) {
      double(:youtube_video, title: "handsome kent",
        description: "long long long description")
    }
    before do
      expect(Yt::Video).to receive(:new).with(id: youtube_video_id).at_least(1).and_return(youtube_video)
    end

    it "creates movie record with fetched info" do
      service.call
      movie = Movie.find_by video_id: youtube_video_id
      expect(movie).to_not be_nil
      expect(movie.video_id).to eq(youtube_video_id)
      expect(movie.user_id).to eq(user.id)
      [:description, :title].each do |field|
        expect(movie.send(field)).to eq(youtube_video.send(field))
      end
    end

    it "raise Error if Youtube video already added" do
      service.call
      expect {
        CreateMovieService.new(url: youtube_url, user_id: user.id).call
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
