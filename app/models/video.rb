class Video < ApplicationRecord
  has_many :video_tags
  has_many :tags, through: :video_tags

  has_many :video_plays
  has_many :users, through: :video_plays

  belongs_to :course
end
