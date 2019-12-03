FactoryBot.define do
  factory :movie, class: Movie do
    sequence(:video_id) { |n| "video#{n}" }
    title{ "title"}
    description{ "description"}
    user
  end
end