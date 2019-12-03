# frozen_string_literal: true

require "rails_helper"
describe "Unsigned User visits Home Page", type: :feature do
  it "works" do
    movies = [1, 2].map { |x| create(:movie, title: "movie title #{x}") }
    visit "/"
    expect(page).to have_selector("form[action='/authenticate']")
    movies.each do |movie|
      expect(page).to have_content(movie.title)
      expect(page).to have_content("Shared by: #{movie.user.email}")
      expect(page).to have_selector("iframe[src=\"https://www.youtube.com/embed/#{movie.video_id}\"]")
    end
  end

  it "shows errors if users visit share page" do
    visit new_movie_path
    expect(page).to have_content("Please sign in.")
  end
end
