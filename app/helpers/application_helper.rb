# frozen_string_literal: true

module ApplicationHelper
  def youtube_embed_url_for(youtube_id)
    "https://www.youtube.com/embed/#{youtube_id}"
  end
end
