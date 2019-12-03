# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :video_id
end
