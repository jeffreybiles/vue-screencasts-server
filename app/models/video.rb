class Video < ApplicationRecord
  has_many :video_tags
  has_many :tags, through: :video_tags

  has_many :video_plays
  has_many :users, through: :video_plays

  belongs_to :course, optional: true

  before_create :generate_slug

  def in_free_period
    published_at && (DateTime.now - 7.days) < published_at
  end

  def released
    published_at && DateTime.now > published_at
  end

  private
      def generate_slug
        self.slug = self.name.parameterize if self.slug.blank?
      end
end
