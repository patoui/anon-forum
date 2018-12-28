class Tag < ApplicationRecord
  validates :name, presence: true, bad_word: true, format: { with: /\A[a-z0-9]+\Z/i, message: "only allows lowercase letters" }

  has_many :associations
  has_many :posts, through: :associations

  def self.popular
    self.left_outer_joins(:associations)
      .distinct
      .select('tags.*, COUNT(associations.tag_id) AS tag_count')
      .group('tag_id')
      .order('tag_count desc')
      .take(10)
  end
end
